Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133113AbRDLM3m>; Thu, 12 Apr 2001 08:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133115AbRDLM3d>; Thu, 12 Apr 2001 08:29:33 -0400
Received: from phoenix.datrix.co.za ([196.37.220.5]:26186 "EHLO
	phoenix.datrix.co.za") by vger.kernel.org with ESMTP
	id <S133113AbRDLM3S>; Thu, 12 Apr 2001 08:29:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marcin Kowalski <kowalski@datrix.co.za>
Reply-To: kowalski@datrix.co.za
Organization: Datrix Solutions
To: davem@redhat.com, viro@math.psu.edu
Subject: Re: [CFT][PATCH] Re: Fwd: Re: memory usage - dentry_cache
Date: Thu, 12 Apr 2001 14:27:24 +0200
X-Mailer: KMail [version 1.2]
Cc: jgarzik@mandrakesoft.com, adilger@turbolinux.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <3AD550F0.8058FAA@mandrakesoft.com> <Pine.GSO.4.21.0104120257070.18135-100000@weyl.math.psu.edu> <15061.27388.843554.687422@pizda.ninka.net>
In-Reply-To: <15061.27388.843554.687422@pizda.ninka.net>
MIME-Version: 1.0
Message-Id: <01041214272403.11986@webman>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Regarding the patch ....

I don't have experience with the linux kernel internals but could this patch 
not lead to a run-loop condition as the only thing that can break our of the 
for(;;) loop is the tmp==&dentry_unused statement. So if the required number 
of dentries does not exist and this condition is not satisfied we would have 
an infinate loop... sorry if this is a silly question.

Also the comment >/* If the dentry was recently referenced, don't free it. 
*/<, the code inside is excuted if the DCACHE_REFERENCED flags are set and in 
the code is is reversing the DCACHE_REFERENCED flag on the dentry and adding 
it to the dentry_unsed list??? So a Refrenched entry is set Not Referenced 
and place in the unsed list?? I am unclear about that... is the comment 
correct or is my understanding lacking (which is very probable :-))..

TIA
MarCin


FYI >-------- 

 void prune_dcache(int count)
{
        spin_lock(&dcache_lock);
        for (;;) {
                struct dentry *dentry;
                struct list_head *tmp;
 
                tmp = dentry_unused.prev;
 
                if (tmp == &dentry_unused)
                        break;
                list_del_init(tmp);
                dentry = list_entry(tmp, struct dentry, d_lru);
 
                /* If the dentry was recently referenced, don't free it. */
                if (dentry->d_flags & DCACHE_REFERENCED) {
                        dentry->d_flags &= ~DCACHE_REFERENCED;
                        list_add(&dentry->d_lru, &dentry_unused);
                        continue;
                }
                dentry_stat.nr_unused--;
 
                /* Unused dentry with a count? */
                if (atomic_read(&dentry->d_count))
                        BUG();
 
                prune_one_dentry(dentry);
                if (!--count)
                        break;
        }
        spin_unlock(&dcache_lock);
}

-----------------------------
     Marcin Kowalski
     Linux/Perl Developer
     Datrix Solutions
     Cel. 082-400-7603
      ***Open Source Kicks Ass***
-----------------------------
