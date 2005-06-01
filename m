Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVFAGp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVFAGp4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 02:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVFAGpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 02:45:55 -0400
Received: from fmr20.intel.com ([134.134.136.19]:7396 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261302AbVFAGpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 02:45:41 -0400
Subject: Re: [linux-pm] Re: [PATCH] Don't explode on swsusp failure to find
	swap
From: Shaohua Li <shaohua.li@intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm <linux-pm@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1117583403.5826.72.camel@gaston>
References: <1117583403.5826.72.camel@gaston>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 14:52:39 +0800
Message-Id: <1117608759.10003.7.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, 2005-06-01 at 07:50 +0800, Benjamin Herrenschmidt wrote:
> On Wed, 2005-06-01 at 00:45 +1000, Benjamin Herrenschmidt wrote: 
> > On Tue, 2005-05-31 at 12:36 +0200, Pavel Machek wrote: 
> > > Hi! 
> > >  
> > > > If we specify a swap device for swsusp using resume= kernel
> argument and 
> > > > that device doesn't exist in the swap list, we end up calling 
> > > > swsusp_free() before we have allocated pagedir_save. That causes
> us to 
> > > > explode when trying to free it. 
> > > >  
> > > > Pavel, does that look right ? 
> > >  
> > > It looks like a workaround. We should not call swsusp_free in
> case 
> > > device does not exists. Quick look did not reveal where the bug
> comes 
> > > from, can you try to trace it? 
> > >                                                             Pavel 
> >  
> > Well, the bug comes from arch code calling swsusp_save() which
> fails, 
> > then we call swsusp_free()
> 
> More specifically, arch suspend calls swsusp_save().
> 
> It fails and returns the error to the arch asm code, which itself 
> returns it to it's caller swsusp_suspend(), which does that:
> 
>         if ((error = swsusp_arch_suspend())) 
>                 swsusp_free();
I encounter a similar issue, when swsusp_swap_check failed.
It seems the swsusp_free isn't required in the failure case,
suspend_prepare_image has correctly handled the failure case to me.
Other arch? I wonder why swsusp_free is called after device_power_down
failed as well. No pages are allocated before device_power_down.

Thanks,
Shaohua

