Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUJRPI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUJRPI1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 11:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266749AbUJRPI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 11:08:27 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:48020 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266741AbUJRPIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 11:08:25 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [patch 1/1] SKAS3: fix mm->dumpable handling
Date: Sat, 16 Oct 2004 17:08:26 +0200
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, uml@hno.marasystems.com,
       mcr@sandelman.ottawa.on.ca
References: <20041014161758.C4CF444BE@zion.localdomain>
In-Reply-To: <20041014161758.C4CF444BE@zion.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410161708.27369.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 October 2004 18:17, blaisorblade_spam@yahoo.it wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Henrik
> Nordstrom <uml@hno.marasystems.com>, Michael Richardson
> <mcr@sandelman.ottawa.on.ca>

> When a child mm is created by opening /proc/mm, without this patch its
> mm->dumpable flag is left set to 0, even when there is no reason to do so.
>
> This way, for instance, if <pid> is the pid of a userspace thread,
> /proc/<pid> is only readable by root (which was the original reason letting
> this be diagnosed by Michael Richardson).

> Paolo and Henrik discussed about this in detail, finally Paolo wrote the
> patch and sent it for comment.
And Paolo (myself) fucked it up:

> +		/* Let's be safe. If we are ptraced from a non-dumpable process,
> +		 * let's not be dumpable. Don't try to be smart and turn
> +		 * current->dumpable to 1: it may be unsafe.*/
> +		if (!current->dumpable) {
This should be current->mm->dumpable, not current->dumpable.
> +			new->dumpable = 0;
> +			wmb();
> +		}
> +
>  		atomic_inc(&new->mm_users);
>  		child->mm = new;
>  		child->active_mm = new;
> _
Also, we have not studied the case of another process trying to ptrace and 
SWITCH_MM a process already having some mm's (it cannot give it any already 
existing mm, because it has not the file descriptor). It seems safe to me, 
but I'm going to study this and put the result in next patch version.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

