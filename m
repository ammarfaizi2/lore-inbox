Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbRGLDXf>; Wed, 11 Jul 2001 23:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbRGLDXZ>; Wed, 11 Jul 2001 23:23:25 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:35512 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S266006AbRGLDXN>; Wed, 11 Jul 2001 23:23:13 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <andrewm@uow.edu.au>
Date: Thu, 12 Jul 2001 13:22:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15181.6162.414864.195108@notabene.cse.unsw.edu.au>
Cc: Peter Zaitsev <pz@spylog.ru>, linux-kernel@vger.kernel.org
Subject: Re: Is  Swapping on software RAID1 possible  in linux 2.4 ?
In-Reply-To: message from Andrew Morton on Thursday July 12
In-Reply-To: <1011478953412.20010705152412@spylog.ru>
	<15172.22988.643481.421716@notabene.cse.unsw.edu.au>
	<11486070195.20010705172249@spylog.ru>
	<15180.63984.722843.539959@notabene.cse.unsw.edu.au>
	<3B4D01E3.1A2F534F@uow.edu.au>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday July 12, andrewm@uow.edu.au wrote:
> 
> Could you please review these changes?

I think I see what you are trying to do, and there is nothing
obviously wrong except this comment :-)

> + * Return true if the caller make take a raid1_bh from the list.
                                ^^^^

but now that I see what the problem is, I think a simpler patch would
be 

--- drivers/md/raid1.c	2001/07/12 02:00:35	1.1
+++ drivers/md/raid1.c	2001/07/12 02:01:42
@@ -83,6 +83,7 @@
 			cnt--;
 		} else {
 			PRINTK("raid1: waiting for %d bh\n", cnt);
+			run_task_queue(&tq_disk);
 			wait_event(conf->wait_buffer, conf->freebh_cnt >= cnt);
 		}
 	}
@@ -170,6 +171,7 @@
 			memset(r1_bh, 0, sizeof(*r1_bh));
 			return r1_bh;
 		}
+		run_task_queue(&tq_disk);
 		wait_event(conf->wait_buffer, conf->freer1);
 	} while (1);
 }


This is needed anyway to be "correct", as you should always unplug
the queues before waiting for IO to complete.

On the issue of whether to pre-allocate some reserved structures or
not, I think it's "6-of-one-half-a-dozen-of-the-other".  My rationale
for pre-allocating was that the buffer that we hold on to would have
been allocated together and so probably are fairly dense within their
pages, and so there is no risk of hogging excess memory that isn't
actually being used.  Mind you, if I was really serious about being
gentle on the memory allocation, I would use 
   kmem_cache_alloc(bh_cachep,SLAB_whatever)
instead of 
   kmalloc(sizeof(struct buffer_head), GFP_whatever)
but I hadn't 'got' the slab stuff properly when I was writing that
code. 

Peter, does the above little patch help your problem?

NeilBrown
