Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVCZXxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVCZXxN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 18:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVCZXxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 18:53:13 -0500
Received: from mail.dif.dk ([193.138.115.101]:15808 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261364AbVCZXww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 18:52:52 -0500
Date: Sun, 27 Mar 2005 00:54:49 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-os <linux-os@analogic.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Jesper Juhl <juhl-lkml@dif.dk>,
       ext2-devel@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/
In-Reply-To: <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
Message-ID: <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
 <1111825958.6293.28.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005, linux-os wrote:

> On Sat, 26 Mar 2005, Arjan van de Ven wrote:
> 
> > On Fri, 2005-03-25 at 17:29 -0500, linux-os wrote:
> > > Isn't it expensive of CPU time to call kfree() even though the
> > > pointer may have already been freed?
> > 
> > nope
> > 
> > a call instruction is effectively half a cycle or less, the branch
> 
> Wrong!
> 
> > predictor of the cpu can predict perfectly where the next instruction is
> > from. The extra if() you do in front is a different matter, that can
> > easily cost 100 cycles+. (And those are redundant cycles because kfree
> > will do the if again anyway). So what you propose is to spend 100+
> > cycles to save half a cycle. Not a good tradeoff ;)
> > 
> 
> Wrong!
> 
[snip]
>
> Always, always, a call will be more expensive than a branch
> on condition. It's impossible to be otherwise. A call requires
> that the return address be written to memory (the stack),
> using register indirection (the stack-pointer).
> 
> If somebody said; "I think that the code will look better
> and the few cycles lost will not be a consequence with modern
> CPUs...", then there is a point. But coming up with this
> disingenuous bullshit is something else.
> 

I tried to create a test to see what the actual impact of this sort of 
change is, the result I reached is below (as well as the code used to 
obtain the numbers): 


Each test is run 10000000 times, and the number of jiffies spent doing the
        kfree();
or
        if (p)
                kfree(p);
is meassured. Total number of jiffies used for that for all 10000000 runs
is reported.

test 0:
        Pointer is NULL half the time, value returned by kmalloc half the
        time.
        kfree() is called on the pointer without checking for NULL first.

test 1:
        Pointer is NULL half the time, value returned by kmalloc half the
        time.
        The pointer is checked for NULL and kfree() is called on the
        pointer only if it is != NULL.

test 2:
        Pointer is NULL the majority of the time, only in 1 out of 50
        cases is it assigned a real value by kmalloc().
        kfree() is called on the pointer without checking for NULL first.

test 3:
        Pointer is NULL the majority of the time, only in 1 out of 50
        cases is it assigned a real value by kmalloc().
        The pointer is checked for NULL and kfree() is called on the
        pointer only if it is != NULL.

test 4:
        Pointer is rarely NULL - only in 1 out of 50 cases.
        kfree() is called on the pointer without checking for NULL first.

test 5:
        Pointer is rarely NULL - only in 1 out of 50 cases.
        The pointer is checked for NULL and kfree() is called on the
        pointer only if it is != NULL.


Here are the numbers from 5 runs on my box - the numbers naturally
differ a bit between each run, but they are quite similar each time :

[ 1395.059375] test 0 used up 235 kfree related jiffies
[ 1395.059385] test 1 used up 195 kfree related jiffies
[ 1395.059389] test 2 used up 66 kfree related jiffies
[ 1395.059392] test 3 used up 20 kfree related jiffies
[ 1395.059395] test 4 used up 366 kfree related jiffies
[ 1395.059398] test 5 used up 428 kfree related jiffies

[ 1412.994705] test 0 used up 231 kfree related jiffies
[ 1412.994744] test 1 used up 209 kfree related jiffies
[ 1412.994748] test 2 used up 68 kfree related jiffies
[ 1412.994751] test 3 used up 12 kfree related jiffies
[ 1412.994754] test 4 used up 362 kfree related jiffies
[ 1412.994757] test 5 used up 392 kfree related jiffies

[ 1423.734356] test 0 used up 245 kfree related jiffies
[ 1423.734366] test 1 used up 179 kfree related jiffies
[ 1423.734370] test 2 used up 78 kfree related jiffies
[ 1423.734373] test 3 used up 30 kfree related jiffies
[ 1423.734376] test 4 used up 384 kfree related jiffies
[ 1423.734379] test 5 used up 385 kfree related jiffies

[ 1434.390194] test 0 used up 242 kfree related jiffies
[ 1434.390203] test 1 used up 179 kfree related jiffies
[ 1434.390207] test 2 used up 70 kfree related jiffies
[ 1434.390210] test 3 used up 16 kfree related jiffies
[ 1434.390214] test 4 used up 365 kfree related jiffies
[ 1434.390217] test 5 used up 397 kfree related jiffies

[ 1446.529856] test 0 used up 231 kfree related jiffies
[ 1446.530046] test 1 used up 232 kfree related jiffies
[ 1446.530117] test 2 used up 79 kfree related jiffies
[ 1446.530211] test 3 used up 16 kfree related jiffies
[ 1446.530278] test 4 used up 360 kfree related jiffies
[ 1446.530362] test 5 used up 412 kfree related jiffies

The conclusions I draw from those numbers are that when NULL pointers are
rare (tests 4 & 5) then it pays off to not have the if() check. When NULL
pointers are common, then there's a small bennefit to having the if() 
check, but we are talking ~50 jiffies (or less) over 10 million runs pr 
test, which is pretty insignificant unless the code is in a very hot path.
When pointers are NULL 50% of the time there's a bennefit to the if(), but 
it's small.
So, unless the code is extremely performance critical *and* the pointer
is NULL more often than not, having the if(pointer != NULL) check before
calling kfree() is pointless and may even be degrading performance if the
pointer is most commonly != NULL.  I'd say that the general rule should
be "don't check for NULL first unless you *know* the pointer will be NULL
>50% of the time"... 
I ran these tests on a 1.4GHz AMD Athlon (T-bird), and with a HZ setting
of 1000.

Am I drawing flawed conclusions here?

If someone could check the sanity of my code used to obtain these numbers
(below), then I'd appreciate it - if the numbers are wrong, then any
conclusion is also wrong of course.


Here's the tiny module I wrote to get the numbers above : 


#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/slab.h>

#define NR_TESTS	10000000

void do_work(void *data);

DECLARE_WORK(work, do_work, NULL);

static int test_time[] = {0, 0, 0, 0, 0, 0};

void do_work(void *data)
{
	unsigned long j;
	static int what_test = 0;
	unsigned long start;
	void *tmp;

	switch (what_test) {
		case 0:
			for (j = 0; j < NR_TESTS; j++) {
				if (j%2 == 0)
					tmp = kmalloc(1, GFP_KERNEL);
				else
					tmp = NULL;
				start = jiffies;
				kfree(tmp);
				test_time[0] += jiffies - start;
			}
			break;
		case 1:
			for (j = 0; j < NR_TESTS; j++) {
				if (j%2 == 0)
					tmp = kmalloc(1, GFP_KERNEL);
				else
					tmp = NULL;
				start = jiffies;
				if (tmp)
					kfree(tmp);
				test_time[1] += jiffies - start;
			}
			break;
		case 2:
			for (j = 0; j < NR_TESTS; j++) {
				if (j%50 == 0)
					tmp = kmalloc(1, GFP_KERNEL);
				else
					tmp = NULL;
				start = jiffies;
				kfree(tmp);
				test_time[2] += jiffies - start;
			}
			break;
		case 3:
			for (j = 0; j < NR_TESTS; j++) {
				if (j%50 == 0)
					tmp = kmalloc(1, GFP_KERNEL);
				else
					tmp = NULL;
				start = jiffies;
				if (tmp)
					kfree(tmp);
				test_time[3] += jiffies - start;
			}
			break;
		case 4:
			for (j = 0; j < NR_TESTS; j++) {
				if (j%50 == 0)
					tmp = NULL;
				else
					tmp = kmalloc(1, GFP_KERNEL);
				start = jiffies;
				kfree(tmp);
				test_time[4] += jiffies - start;
			}
			break;
		case 5:
			for (j = 0; j < NR_TESTS; j++) {
				if (j%50 == 0)
					tmp = NULL;
				else
					tmp = kmalloc(1, GFP_KERNEL);
				start = jiffies;
				if (tmp)
					kfree(tmp);
				test_time[5] += jiffies - start;
			}
			break;
		default:
			break;
	}
	printk(KERN_ALERT "test %d done.\n", what_test);
	
	if (what_test < 5)
		schedule_delayed_work(&work, 1);
	else
		printk(KERN_ALERT "All tests done...\n");

	what_test++;
}


static int kfreetest_init(void)
{
	schedule_work(&work);
	return 0;
}

static void kfreetest_exit(void)
{
	int i;

	cancel_delayed_work(&work);
	flush_scheduled_work();
	for (i = 0; i < 6; i++)
		printk(KERN_ALERT "test %d used up %d kfree related jiffies\n", i, test_time[i]);
}


module_init(kfreetest_init);
module_exit(kfreetest_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Jesper Juhl");



-- 
Jesper Juhl <juhl-lkml@dif.dk>


