Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263944AbUEMIql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbUEMIql (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 04:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbUEMIql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 04:46:41 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:64886 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263944AbUEMIqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 04:46:38 -0400
Date: Thu, 13 May 2004 16:47:55 +0800
From: fisherman <fishermandong@yahoo.com.cn>
X-Mailer: The Bat! (v2.10.01) Business
Reply-To: fisherman <fishermandong@yahoo.com.cn>
X-Priority: 3 (Normal)
Message-ID: <821514233.20040513164755@yahoo.com.cn>
To: linux-kernel@vger.kernel.org
Subject: sleep in make_request_fn() casue system no response(2.4.20-8)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   I am writting a virtual device driver, I found that if I add sleep
into function make_request_fn(), then use dd to copy 100M  data to the
corresponding device, the system goes dead(keyboard & mouse have no
response, can't login by telnet).

   I also tried to add sleep into LVM's driver, and the test result is
similar to our driver do, the test about LVM is shown as follws:

[1] source modification
-------- source begin --------
static int lvm_make_request_fn(request_queue_t * q,
                               int rw, struct buffer_head *bh)
{
        current->state = TASK_INTERRUPTIBLE;  /* newly added */
        schedule_timeout(1);                  /*newly added*/
        return (lvm_map(bh, rw) <= 0) ? 0 : 1;
}   
-------- source end --------

[2] test 1
   after building the module, the system will go dead if I run the
folling command to write data to a LV(100M bye ONE command):
#dd if=/dev/zero of=/dev/vg_data1/dlv3 bs=1024 count=100000

[3] test 2
    but write operation with smaller size can be repeated many times, the
following script runs OK.
-------- script begin --------
#write 10M for 10 times
i=0
pos=0
cnt=10000
while [ $i -lt 10 ] 
do
dd if=/dev/zero of=/dev/vg_data1/dlv3 bs=1024 count=$cnt seek=$pos
i=`expr $i + 1`
pos=`expr $pos + $cnt`
done
-------- script end --------

[4] environment
    redhat 9;
    kernel 2.4.20-8.
    
    I repeated test 1 and test 2 for many times, ant the result are the
same.

Can anyone tell me the reason?

thanks.




