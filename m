Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVHBGO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVHBGO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 02:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVHBGNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 02:13:05 -0400
Received: from graphe.net ([209.204.138.32]:21383 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261386AbVHBGLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 02:11:52 -0400
Date: Mon, 1 Aug 2005 23:11:49 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Paul Jackson <pj@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [PATCH] String conversions for memory policy
In-Reply-To: <20050801223304.2a8871e8.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0508012311170.16052@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
 <20050729152049.4b172d78.pj@sgi.com> <Pine.LNX.4.62.0507291746000.8663@graphe.net>
 <20050729230026.1aa27e14.pj@sgi.com> <Pine.LNX.4.62.0507301042420.26355@graphe.net>
 <20050730181418.65caed1f.pj@sgi.com> <Pine.LNX.4.62.0507301814540.31359@graphe.net>
 <20050730190126.6bec9186.pj@sgi.com> <Pine.LNX.4.62.0507301904420.31882@graphe.net>
 <20050730191228.15b71533.pj@sgi.com> <Pine.LNX.4.62.0508011147030.5541@graphe.net>
 <20050801160351.71ee630a.pj@sgi.com> <Pine.LNX.4.62.0508011618120.9351@graphe.net>
 <20050801165947.36b5da96.pj@sgi.com> <Pine.LNX.4.62.0508011713540.9824@graphe.net>
 <20050801223304.2a8871e8.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you rework the patch to all of that? Seems that you have a clear 
vision as to where to go.

On Mon, 1 Aug 2005, Paul Jackson wrote:

> Christoph wrote:
> > New version without the magic numbers ...
> 
> Good.
> 
> ===
> 
> How about replacing:
> 
>   static const char *policy_types[] = { "default", "prefer", "bind", "interleave" };
> 
> with:
> 
>   static const char *policy_types[] = {
> 	[MPOL_DEFAULT]    = "default",
> 	[MPOL_PREFERRED]  = "prefer",
> 	[MPOL_BIND]       = "bind",
> 	[MPOL_INTERLEAVE] = "interleave"
>   };
> 
> so that the mapping of the MPOL_* define constants to strings is
> explicit, not implicit.
> 
> ===
> 
> Maybe I need more caffeine, but the following tests seem backwards:
> 
> +	if (buffer + maxlen > p + l + 1)
> +		return -ENOSPC;
> 
> and
> 
> +		if (buffer + maxlen > p + 2)
> +			return -ENOSPC;
> 
> ===
> 
> Can the following:
> 
> +	int l;
> +	...
> +
> +	l = strlen(policy_types[mode]);
> +	if (buffer + maxlen > p + l + 1)
> +		return -ENOSPC;
> +	strcpy(p, policy_types[mode]);
> +	p += l;
> +
> +	if (!nodes_empty(nodes)) {
> +
> +		if (buffer + maxlen > p + 2)
> +			return -ENOSPC;
> +
> +		*p++ = '=';
> +	 	p += nodelist_scnprintf(p, buffer + maxlen - p, nodes);
> +	}
> 
> be rewritten to:
> 
> 	char *bufend = buffer + maxlen;
> 	...
> 
> 	p += scnprintf(p, bufend - p, "%s", policy_types[mode]);
> 	if (!nodes_empty(nodes)) {
> 		p += scnprintf(p, bufend - p, "=");
> 		p += nodelist_scnprintf(p, bufend - p, nodes);
> 	}
> 	if (p >= bufend - 1)
> 		return -ENOSPC;
> 
> Less code, more consistent code for each buffer addition, fails with
> ENOSPC in the case that the nodelist only partially fits rather than
> truncating it without notice, and fixes any possible problem with the
> above tests being backwards - by removing the tests ;).
> 
> This suggested replacement code does have one weakness, in that it
> cannot distinguish the case that the buffer was exactly the right
> size from the case it was too small, and errors with -ENOSPC in
> either case.  I don't think that this case is worth adding extra
> logic to distinguish, in this situation.
> 
> ===
> 
> +	for(mode = 0; mode <= MPOL_MAX; mode++) {
> 
> Space after 'for'
> 
> ===
> 
> There should probably be comments that these routines must
> execute in the context of the task whose mempolicies are
> being displayed or modified.
> 
> ==
> 
> There should probably be a doc style comment introducing
> the mpol_to_str() and str_to_mpol() routines, as described
> in Documentation/kernel-doc-nano-HOWTO.txt.
> 
> -- 
>                   I won't rest till it's the best ...
>                   Programmer, Linux Scalability
>                   Paul Jackson <pj@sgi.com> 1.925.600.0401
> 
