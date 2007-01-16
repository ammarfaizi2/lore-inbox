Return-Path: <linux-kernel-owner+w=401wt.eu-S1751243AbXAPSBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbXAPSBU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbXAPSBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:01:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:17812 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbXAPSBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:01:19 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hUtnsakf9EjZGrHmRLMNtzwtrU6x9iWvre2aCffp4anQJfGgDWPjmoA8sV1u+kHxciNUvgZymnnx5ielDBHb9IGbuMTQw6Df8n5+pCDcldhGRbOINLNLTIizLrCM0/mFYiyGU6fwp0+NZZ8S/1HrkCEpCWLspHT6JfYVMhhESy4=
Message-ID: <808209b40701161001o6e691d8fh9a982326fadeba57@mail.gmail.com>
Date: Tue, 16 Jan 2007 13:01:12 -0500
From: "Cheng Tsai" <cheng705@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: hrtimers on arm5vtel poss bug
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone played with hrtimers?

I setup a hrtimer to expire in 50,000,000 ns (20 hz), but it returns
much faster than specified.  Changing sample_ns_interval (say to
80,000,000ns or 1,000,000,000) does not scale delta_time as expected.

So I think I may have found a bug in the clock/hrtimers code.

Taking the last pair of OSCR values, (8992-4107)/3,686,400=0.001325141
sec.  This number is the same regardless of sample_ns_interval.  Too
slow to be expiring immediately, but it is consistent.

I have not tested this code against the latest kernel version.

Pertinent info: kernel is stock 2.6.18, with minor patches to work
with the gumstix platform, hrtimers on, HZ=1000, and processor is a
pxa255.

enclosed: sample dmesg output, relevant code from module

cheng tsai


My output from dmesg:
testing timing
system hrtimer resolution is: 0 s, 999891 ns
t:-1059931735
t:-1059926802
t:-1059921915
t:-1059917039
t:-1059912174
t:-1059907294
t:-1059902416
t:-1059897549
t:-1059892635
t:-1059887760
t:-1059882895
t:-1059878015
t:-1059873133
t:-1059868270
t:-1059863385
t:-1059858512
t:-1059853645
t:-1059848732
t:-1059843856
t:-1059838992
t:-1059834107
target sample_ns_interval was 50000000
hrtimertest: driver seemed to register correctly
hrtimertest: driver unregistered



/* This module tests hrtimers and shows a possible unit conversion
 * problem; target requested rate is different from the rate calculated
 * by using the free running counter.
 *
 * problem exists on 2.6.18. Need to test against the newest version of
 * the kernel.
 */
#include <linux/init.h>
#include <linux/module.h>
#include <linux/errno.h>
#include <asm/arch/hardware.h>  //needed for __reg
#include <asm/arch/pxa-regs.h>  //needed for OSCR
#include <linux/hrtimer.h>
#include <linux/ktime.h>
#include <linux/time.h>
#define MODULE_NAME "hrtimertest"
#define DRVNAME  "hrtimertest"
#define MAX 20
struct hrtimer timer;
unsigned char cnt;
static unsigned long sample_ns_interval = 50000000;  //50000000=20hz
module_param( sample_ns_interval, long, S_IRUGO);
MODULE_PARM_DESC( sample_ns_interval, "Desired sample rate.");
int recall_me(struct hrtimer* hrtimer_p){
 static int32_t temp;
 // OSCR is the free running counter on ARM5vtel, actual time elapsed
 // can be calculated from this by taking the delta, and dividing by
 // 3.6864 Mhz
 // I know this is a hackish way to check actual time.
 temp=OSCR;
 printk("t:%d\n",temp);
 if(cnt<MAX){
   hrtimer_restart(hrtimer_p);
   cnt++;
  }
 return 0;
}
static int __init hrtimertest_init(void){
 struct timespec tp;
 ktime_t mytime;

 mytime.tv.sec=0;
 mytime.tv.nsec=sample_ns_interval;
 cnt=0;
 printk("testing timing\n");

 hrtimer_init(&timer,CLOCK_MONOTONIC,HRTIMER_ABS);
 timer.function=recall_me;
 hrtimer_start(&timer, mytime, HRTIMER_ABS);

 hrtimer_get_res(CLOCK_MONOTONIC, &tp);

 printk( "system hrtimer resolution is: %d s, %d ns\n", tp.tv_sec,tp.tv_nsec);
 printk( "target sample_ns_interval was %d\n", sample_ns_interval);
 printk( KERN_ERR MODULE_NAME ": driver seemed to register correctly\n");

 return 0;
}
module_init(hrtimertest_init);
static void __exit hrtimertest_exit(void){
 hrtimer_cancel(&timer);

 printk( KERN_ERR MODULE_NAME ": driver unregistered \n");
 return;
}
module_exit(hrtimertest_exit);
MODULE_DESCRIPTION("hrtimertest strap");
MODULE_AUTHOR("Cheng Tsai, <cheng705 at gmail dot com>");
MODULE_LICENSE("GPL v2");
MODULE_VERSION("$Date: 2006/11/22 21:43:03 $");
