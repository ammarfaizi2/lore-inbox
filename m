Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269321AbUI3QaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269321AbUI3QaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 12:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269340AbUI3QaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 12:30:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15744 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269321AbUI3Q3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 12:29:08 -0400
Date: Thu, 30 Sep 2004 09:27:44 -0700
From: Paul Jackson <pj@sgi.com>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: rml@novell.com, akpm@osdl.org, ttb@tentacle.dhs.org,
       cfriesen@nortelnetworks.com, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       iggy@gentoo.org
Subject: Re: [RFC][PATCH] inotify 0.10.0
Message-Id: <20040930092744.5eb5ea10.pj@sgi.com>
In-Reply-To: <1096558180.26742.133.camel@orca.madrabbit.org>
References: <1096250524.18505.2.camel@vertex>
	<20040926211758.5566d48a.akpm@osdl.org>
	<1096318369.30503.136.camel@betsy.boston.ximian.com>
	<1096350328.26742.52.camel@orca.madrabbit.org>
	<20040928120830.7c5c10be.akpm@osdl.org>
	<41599456.6040102@nortelnetworks.com>
	<1096390398.4911.30.camel@betsy.boston.ximian.com>
	<1096392771.26742.96.camel@orca.madrabbit.org>
	<1096403685.30123.14.camel@vertex>
	<20040929211533.5e62988a.akpm@osdl.org>
	<1096508073.16832.17.camel@localhost>
	<20040929200525.4e7bb489.pj@sgi.com>
	<1096558180.26742.133.camel@orca.madrabbit.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This changes an O(1) process to O(N),

At the microlevel, yes.  But:

 1) If one takes as the "unit of measurement" the number of
    system calls made, it's more like O(N/128), given that
    one might average 128 directory entries per getdents()
    call.

 2) This can be cached, with user code mapping inode->d_ino
    to d_name, and then the cached name checked with a single
    stat(2) call to ensure it wasn't stale.

Be leary of micro optimizations imposing a poorer design, especially
across major API boundaries.  Simply waving "O(N)" in our face may not
be adequately persuasive.  You might need a compelling performance
analysis, showing that you can only meet critical goals by passing the
name.  Such analysis may already be intuitively obvious to you.  If it's
already earlier on this thread, don't hesitate to tell me where to go
back and read it.  But right now I am unaware of any such compelling
need.

And there is a long history of pain in Unix dealing with variable length
return values.  Much better to deal with that entirely in user space
code under your control, than to have to align kernel and glibc code in
addition to your code, to get something fixed.  More often than not,
you will end up with faster code when you control the details, than if
you have to align heaven and earth to make changes.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
