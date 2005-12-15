Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVLOVPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVLOVPG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVLOVPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:15:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17867 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751088AbVLOVPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:15:04 -0500
To: JANAK DESAI <janak@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, viro@ftp.linux.org.uk,
       chrisw@osdl.org, dwmw2@infradead.org, jamie@shareable.org,
       serue@us.ibm.com, mingo@elte.hu, linuxram@us.ibm.com, jmorris@namei.org,
       sds@tycho.nsa.gov, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/9] unshare system call: system call handler
 function
References: <1134513959.11972.167.camel@hobbs.atlanta.ibm.com>
	<m1k6e687e2.fsf@ebiederm.dsl.xmission.com>
	<43A1D435.5060602@us.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 15 Dec 2005 14:13:28 -0700
In-Reply-To: <43A1D435.5060602@us.ibm.com> (JANAK DESAI's message of "Thu,
 15 Dec 2005 15:38:13 -0500")
Message-ID: <m1d5jy83nr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JANAK DESAI <janak@us.ibm.com> writes:

> Eric W. Biederman wrote:
>
>>If it isn't legal how about we deny the unshare call.
>>Then we can share this code with clone.
>>
>>Eric
>>
>>
>>
>>
> unshare is doing the reverse of what clone does. So if you are unsharing
> namespace
> you want to make sure that you are not sharing fs. That's why the CLONE_FS flag
> is forced (meaning you are also going to unshare fs). Since namespace is shared
> by default and fs is not, if clone is called with CLONE_NEWNS, the intent is to
> create a new namespace, which means you cannot share fs. clone checks to
> makes sure that CLONE_NEWNS and CLONE_FS are not specified together, while
> unshare will force CLONE_FS if CLONE_NEWNS is spefcified. Basically you
> can have a shared namespace and non shared fs, but not the other way around and
> since clone and unshare are doing opposite things, sharing code between them
> that
> checks constraints on the flags can get convoluted.

I follow but I am very disturbed.

You are leaving CLONE_NEWNS to mean you want a new namespace.

For clone CLONE_FS unset means generate an unshared fs_struct
          CLONE_FS set   means share the fs_struct with the parent

But for unshare CLONE_FS unset means share the fs_struct with others
            and CLONE_FS set   means generate an unshared fs_struct

The meaning of CLONE_FS between the two calls in now flipped,
but CLONE_NEWNS is not.  Please let's not implement it this way.

Part of the problem is the double negative in the name, leading
me to suggest that sys_share might almost be a better name.

So please code don't invert the meaning of the bits.  This will
allow sharing of the sanity checks with clone.

In addition this leaves open the possibility that routines like
copy_fs properly refactored can be shared between clone and unshare.


Eric
