Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937924AbWLGBgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937924AbWLGBgK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937925AbWLGBgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:36:09 -0500
Received: from gw.goop.org ([64.81.55.164]:39777 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937924AbWLGBgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:36:07 -0500
Message-ID: <45777002.6050009@goop.org>
Date: Wed, 06 Dec 2006 17:36:02 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Zach Brown <zach.brown@oracle.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH RFC] use of activate_mm in fs/aio.c:use_mm()?
References: <45776D54.7030409@goop.org>
In-Reply-To: <45776D54.7030409@goop.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> I'm wondering if activate_mm() is the right thing to be using in
> use_mm(); shouldn't this be switch_mm()?
>
> On normal x86, they're synonymous, but for the Xen patches I'm adding a
> hook which assumes that activate_mm is only used the first time a new mm
> is used after creation (I have another hook for dealing with dup_mm).  I
> think this use of activate_mm() is the only place where it could be used
> a second time on an mm.
>
> From a quick look at the other architectures I think this is OK (most
> simply implement one in terms of the other), but some are doing some
> subtly different stuff between the two.
>
> Thanks,
>     J
>
>
>   
Er, lets try that again:

diff -r 455b71ed4525 fs/aio.c
--- a/fs/aio.c	Wed Dec 06 13:16:42 2006 -0800
+++ b/fs/aio.c	Wed Dec 06 17:17:43 2006 -0800
@@ -588,7 +588,7 @@ static void use_mm(struct mm_struct *mm)
 	 * Note that on UML this *requires* PF_BORROWED_MM to be set, otherwise
 	 * it won't work. Update it accordingly if you change it here
 	 */
-	activate_mm(active_mm, mm);
+	switch_mm(active_mm, mm, tsk);
 	task_unlock(tsk);
 
 	mmdrop(active_mm);


