Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbUA3XVi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 18:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUA3XVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 18:21:38 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:56302 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S264366AbUA3XVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 18:21:36 -0500
Date: Fri, 30 Jan 2004 15:21:03 -0800
From: Tim Hockin <thockin@sun.com>
To: Andrew Morton <akpm@osdl.org>
Cc: arjanv@redhat.com, thomas.schlichter@web.de, thoffman@arnor.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc2-mm2
Message-ID: <20040130232103.GF9155@sun.com>
Reply-To: thockin@sun.com
References: <1075489136.5995.30.camel@moria.arnor.net> <200401302007.26333.thomas.schlichter@web.de> <1075490624.4272.7.camel@laptop.fenrus.com> <20040130114701.18aec4e8.akpm@osdl.org> <20040130201731.GY9155@sun.com> <20040130123301.70009427.akpm@osdl.org> <20040130211256.GZ9155@sun.com> <20040130140024.4b409335.akpm@osdl.org> <20040130223105.GC9155@sun.com> <20040130150819.2425386b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130150819.2425386b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 03:08:19PM -0800, Andrew Morton wrote:
> I think this is right - the NFSEXP_ALLSQUASH case appears to be clearing
> all groups.  When this settles down we need to run it all by Neil.
> 
> Do we need to handle the return value from set_current_groups(), or should
> that guy be simply returning void?

set_current_groups() can fail if security_task_setgroups() fails.

> +	struct group_info *group_info = NULL;

Why init to NULL?

> +	ngroups = 0;
> +	if (!(exp->ex_flags & NFSEXP_ALLSQUASH)) {
> +		for (i = 0; i < SVC_CRED_NGROUPS; i++) {
> +			if (cred->cr_groups[i])
> +				ngroups++;
> +		}
> +	}

I though of doing this, but passed in favor of simplicity of patch :)

The original made a specific point of doing
	gid_t group = cred->cr_groups[i];
	if (group == (gid_t) NOGROUP)
		break;

So the count loop should probably be
	ngroups = 0;
	if (!(exp->ex_flags & NFSEXP_ALLSQUASH)) {
		for (i = 0; i < SVC_CRED_NGROUPS; i++) {
			gid_t group = cred->cr_groups[i];
			if (group == (gid_t) NOGROUP)
				break;
			ngroups++;
		}
	}
So that we don't assume anything about NOGROUP.

> +	return ret;

The caller in fs/nfsd/nfsfh.c still needs to check the return value and do
something with it, or all this is just dumb.

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
