Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbRLTAvt>; Wed, 19 Dec 2001 19:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285724AbRLTAvj>; Wed, 19 Dec 2001 19:51:39 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:63243 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285720AbRLTAv3>; Wed, 19 Dec 2001 19:51:29 -0500
Message-ID: <3C2135D3.C5AE16A7@zip.com.au>
Date: Wed, 19 Dec 2001 16:50:27 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulus@samba.org
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-rc2 BUG at slab.c:1110
In-Reply-To: <15393.11001.446919.939724@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> 
> So, is this devfs's fault for not allowing devfs_unregister to be
> called from interrupt context, or is it ide-cs's fault for calling
> ide_unregister from interrupt context?
> 

ide-cs, I'd say.

The way hotplug generally avoids this problem is via schedule_task() - that
was why it was written in the first place, I think.

And given that we need to bump the event up to process context, we may
as well do it at the earliest stage.  Looks like the fix it to kill
off the timer altogether, replace it with a tqueue and ask keventd
to run ide_release.
