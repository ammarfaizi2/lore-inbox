Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVBPQDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVBPQDz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 11:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVBPQDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 11:03:55 -0500
Received: from postino4.roma1.infn.it ([141.108.26.24]:53643 "EHLO
	postino4.roma1.infn.it") by vger.kernel.org with ESMTP
	id S262057AbVBPQCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 11:02:42 -0500
Message-ID: <42136E9F.1060804@roma1.infn.it>
Date: Wed, 16 Feb 2005 17:02:39 +0100
From: Davide Rossetti <davide.rossetti@roma1.infn.it>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: workqueues and schedule()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.29.0.5; VDF 6.29.0.128
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<environment>
I'm authoring a (GPL) driver for a custom 3D network card.
</environment>

on calling some polling functions from within a workqueue, I'm getting 
lockups... sysrq-p got it clear I have a workqueue thread down into 
schedule_timeout().
is considered polite to call schedule ? is in_softirq() capable to diff 
workqueue/normal case ?

static int __apedev_hdrring_poll_end_dma(ApeDev* apedev, struct 
ApeHdrRing* ring)
{
    int ret = 0;
    int counter;

    APE_BUG_ON(0 == ring);
    APE_BUG_ON(0 == apedev);   
   
    // here I poll on the rwbuf memory content till dma is done
    ndelay(5*HZPCI);
    APEDEV_COUNTER_INC(apedev, hdrring_poll_ndelay_cnt);
    counter = 0;
    while(1) {
        if(0 != __apedev_hdrring_check_magic(apedev, ring))
            break;

        counter++;
        ndelay(20*HZPCI);
        if(0 == counter % 512) {
            APEDEV_COUNTER_INC(apedev, hdrring_poll_ndelay_cnt);
            ndelay(50*HZPCI);
        }
        if(counter==2048*16) { // time past is 2048*16/512*50HZPCI
            PDEBUG("counter overflows 2048*16, delaying 1 jiffy\n");

            set_current_state(TASK_UNINTERRUPTIBLE);
            schedule_timeout(MAX(HZ/100,1));            //<----

            counter = 0;
            APEDEV_COUNTER_INC(apedev, hdrring_poll_resched_cnt);
        }
        if(signal_pending(current)) {
            PERROR("GOT SIGNAL!!!\n");
            //apedev_v3_dump_regs(apedev);
            ret = -EINTR;
            goto err;
        }
    }
 err:
    return ret;
}

// fast path
static inline int apedev_hdrring_poll_end_dma(ApeDev* apedev, struct 
ApeHdrRing* ring)
{
    int ret = 0;
    int retcode;

    APE_BUG_ON(0 == ring);
    APE_BUG_ON(0 == apedev);   
   
    retcode = __apedev_hdrring_check_magic(apedev, ring);
    if(retcode < 0) {
        PERROR("error in check_magic\n");
        ret = retcode;
        // exit with true...
    } else if(ret==0) {
        ret = __apedev_hdrring_poll_end_dma(apedev, ring);
        PDEBUG("ret=%d\n", ret);
    }
    return ret;
}


