Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRCWKmu>; Fri, 23 Mar 2001 05:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbRCWKml>; Fri, 23 Mar 2001 05:42:41 -0500
Received: from epic8.Stanford.EDU ([171.64.15.41]:14062 "EHLO
	epic8.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S130507AbRCWKm0>; Fri, 23 Mar 2001 05:42:26 -0500
Date: Fri, 23 Mar 2001 02:41:40 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: <linux-kernel@vger.kernel.org>
cc: <mc@cs.stanford.edu>
Subject: [CHECKER] 4 warnings in kernel/module.c
Message-ID: <Pine.GSO.4.31.0103230236500.3192-100000@epic8.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, we modified the block checker and run it again on linux 2.4.1. (The
block checker flags an error when blocking functions are called with
either interrupts disabled or a spin lock held. )

It gave us 4 warnings in kernel/module.c. Because we are unaware of the
contexts where these functions are called, we are not sure if these 4
warnings are real errors or false positives. Please help us to verify them
or show that they are false positives.

As usual, please CC us at mc@cs.stanford.edu. Any help will be
appreciated.

---------------------------------------------------------

[UNKNOWN] get_mod_name->__get_free_page(GFP_KERNEL). This is in the
KERNEL. Definitely need to verify

/u2/acc/oses/linux/2.4.1/kernel/module.c:290:sys_create_module:
ERROR:BLOCK:289:290:calling blocking fn 'get_mod_name' w/ spin lock held
[type=GLOBAL]:289

Start --->
	lock_kernel();

Error --->
	if ((namelen = get_mod_name(name_user, &name)) < 0) {
		error = namelen;
---------------------------------------------------------

[UNKNOWN] get_mod_name->__get_free_page(GFP_KERNEL) This is in the KERNEL.
Definitely need to verify

/u2/acc/oses/linux/2.4.1/kernel/module.c:599:sys_delete_module:
ERROR:BLOCK:597:599:calling blocking fn 'get_mod_name' w/ spin lock held
[type=GLOBAL]:597

Start --->
	lock_kernel();
	if (name_user) {
Error --->
		if ((error = get_mod_name(name_user, &name)) < 0)
			goto out;
---------------------------------------------------------

[UNKNOWN] need to verify. in the KERNEL!

/u2/acc/oses/linux/2.4.1/kernel/module.c:376:sys_init_module:
ERROR:BLOCK:342:376:calling blocking fn 'copy_from_user' w/ spin lock held
[type=LOCAL]:342

Start --->
	lock_kernel();
Error --->
	if ((namelen = get_mod_name(name_user, &name)) < 0) {
		error = namelen;
		goto err0;
	}

	... DELETED 26 lines ...

		goto err1;
	}
	strcpy(name_tmp, mod->name);

Error --->
	error = copy_from_user(mod, mod_user, mod_user_size);
	if (error) {
---------------------------------------------------------

[UNKNOWN] need to verify. in the KERNEL!

/u2/acc/oses/linux/2.4.1/kernel/module.c:888:sys_query_module:
ERROR:BLOCK:881:888:calling blocking fn 'get_mod_name' w/ spin lock held
[type=GLOBAL]:881

Start --->
	lock_kernel();
	if (name_user == NULL)
		mod = &kernel_module;
	else {
		long namelen;
		char *name;

Error --->
		if ((namelen = get_mod_name(name_user, &name)) < 0) {
			err = namelen;
---------------------------------------------------------

A few questions:

1. Is it OK to call blocking functions in the functions like
/init/main.c:init and init/main.c:start_kernel with a spin lock held? It
seems OK because the system is booting when these functions are called.

2. Can functions like kmem_cache_create, kmem_cache_alloc, alloc_page
block?






