Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262080AbTCVJ73>; Sat, 22 Mar 2003 04:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262082AbTCVJ73>; Sat, 22 Mar 2003 04:59:29 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:30656 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S262080AbTCVJ71>;
	Sat, 22 Mar 2003 04:59:27 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303221010.h2MAAS506370@csl.stanford.edu>
Subject: [CHECKER] deadlock in 2.5.62/fs/lockd/svc*.c?
To: linux-kernel@vger.kernel.org
Date: Sat, 22 Mar 2003 02:10:28 -0800 (PST)
Cc: engler@csl.stanford.edu (Dawson Engler)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

here's a more interesting potential deadlock in  the 
	2.5.62/fs/lockd/svc*.c
code that requires the miscordination of three threads.  It might be
a false because of 
        1. infeasible callchain path or 

        2. the two struct nlm_file.f_sema pointers cannot actually point
	to the same object.

It requires three threads: 
        thread 1: acquires nlm_file_sema then tries to get file->f_sema
        thread 2: acquires file->f_sema and tries to get nlm_host_sema
        thread 3: acquires nlm_host_sema and tries to get nlm_file_sema

Any feedback on this one would be great.

Dawson


BUG: ERROR: 3 thread global-global deadlock.
   <&nlm_file_sema>-><&nlm_host_sema> occurred 4 times
   <&nlm_host_sema>-><&nlm_file_sema> occurred 5 times


Plausible chain
   thread 1: <&nlm_file_sema,struct nlm_file.f_sema>
    depth = 3:
        2.5.62/fs/lockd/svcsubs.c:nlm_traverse_files:218

        down(&nlm_file_sema);

           ->2.5.62/fs/lockd/svcsubs.c:nlm_traverse_files:218
           	->nlm_traverse_files:224
           	->nlm_inspect_file:202
           	->end=fs/lockd/svclock.c:nlmsvc_traverse_blocks:274:down

        	down(&file->f_sema);

Seems like a plausible chain.
   thread 2: <struct nlm_file.f_sema,&nlm_host_sema>
    depth = 4:
        2.5.62/fs/lockd/svclock.c:nlmsvc_lock:309

        /* Lock file against concurrent access */
        down(&file->f_sema);


           ->2.5.62/fs/lockd/svclock.c:nlmsvc_lock:309
           	->nlmsvc_lock:351
           	->nlmsvc_create_block:179
           		->2.5.62/fs/lockd/host.c:nlmclnt_lookup_host:44
           		    ->end=nlm_lookup_host:74:down

        			/* Lock hash table */
        			down(&nlm_host_sema);

Seems reasonable.
  <&nlm_host_sema>-><&nlm_file_sema> =
    depth = 4:
        2.5.62/fs/lockd/host.c:nlm_lookup_host:74
           /* Lock hash table */
           down(&nlm_host_sema);

           ->2.5.62/fs/lockd/host.c:nlm_lookup_host:74
           ->nlm_lookup_host:77
           ->nlm_gc_hosts:319
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/lockd/svcsubs.c:nlmsvc_mark_resources:279
           ->end=nlm_traverse_files:218:down
           ->2.5.62/fs/lockd/svcsubs.c:nlm_traverse_files:218

        	down(&nlm_file_sema);


