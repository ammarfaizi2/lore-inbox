Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWDUSGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWDUSGV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 14:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWDUSGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 14:06:21 -0400
Received: from ns.suse.de ([195.135.220.2]:41906 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932320AbWDUSGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 14:06:20 -0400
Date: Fri, 21 Apr 2006 11:01:15 -0700
From: Tony Jones <tonyj@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 6/11] security: AppArmor - Userspace interface
Message-ID: <20060421180115.GB740@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419174954.29149.80464.sendpatchset@ermintrude.int.wirex.com> <20060420213943.GD2360@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420213943.GD2360@ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 09:39:43PM +0000, Pavel Machek wrote:
> Hi!
> 
> > This patch implements the interface between the userspace policy loader
> > and the kernel module.   It is called by the .load, .remove and .replace
> > file_operations hooks implemented in apparmorfs.c.
> > 
> > The code is reponsible for serializing data in a platform independant 
> > manner from userspace and creating/activating the necessary apparmor 
> > profiles.
> 
> Documentation patch describing what kind of data you pass here would
> be nice.

Very true. We will add it.

> > +#include "match/match.h"
> > +
> > +/* aa_code defined in module_interface.h */
> > +
> > +const int aacode_datasize[] = { 1, 2, 4, 8, 2, 2, 4, 0, 0, 0, 0, 0, 0 };
> 
> I believe this needs a comment.

Yep.

> > +
> > +/* inlines must be forward of there use in newer version of gcc,
> > +   just forward declaring with a prototype won't work anymore */
> 
> their use?

Thanks

> > +/**
> > + * aa_activate_profile - unpack a serialized profile
> > + * @e: serialized data extent information
> > + * @error: error code returned if unpacking fails
> > + */
> > +static struct aaprofile *aa_activate_profile(struct aa_ext *e, ssize_t *error)
> > +{
> > +	struct aaprofile *profile = NULL;
> > +	const char *rulename = "";
> > +	const char *error_string = "Invalid Profile";
> > +
> > +	*error = -EPROTO;
> > +
> > +	profile = alloc_aaprofile();
> > +	if (!profile) {
> > +		error_string = "Could not allocate profile";
> > +		*error = -ENOMEM;
> > +		goto fail;
> > +	}
> > +
> > +	/* check that we have the right struct being passed */
> > +	AA_READ_X(e, AA_STRUCT, NULL, "profile");
> > +	AA_READ_X(e, AA_DYN_STRING, &profile->name, NULL);
> > +
> > +	error_string = "Invalid flags";
> > +	/* per profile debug flags (debug, complain, audit) */
> > +	AA_READ_X(e, AA_STRUCT, NULL, "flags");
> > +	AA_READ_X(e, AA_U32, &(profile->flags.debug), "profile.flags.debug");
> > +	AA_READ_X(e, AA_U32, &(profile->flags.complain),
> > +		  "profile.flags.complain");
> > +	AA_READ_X(e, AA_U32, &(profile->flags.audit), "profile.flags.audit");
> > +	AA_READ_X(e, AA_STRUCTEND, NULL, NULL);
> > +
> > +	error_string = "Invalid capabilities";
> > +	AA_READ_X(e, AA_U32, &(profile->capabilities), "profile.capabilities");
> > +
> > +	/* get the file entries. */
> > +	AA_ENTRY_LIST("pgent");		/* pcre rules */
> > +	AA_ENTRY_LIST("sgent");		/* simple globs */
> > +	AA_ENTRY_LIST("fent");		/* regular file entries */
> > +
> > +	/* get the net entries */
> > +	if (aa_is_nameX(e, AA_LIST, NULL, "net")) {
> > +		error_string = "Invalid net entry";
> > +		while (!aa_is_nameX(e, AA_LISTEND, NULL, NULL)) {
> > +			if (!aa_activate_net_entry(e))
> > +				goto fail;
> > +		}
> > +	}
> > +	rulename = "";
> > +
> > +	/* get subprofiles */
> > +	if (aa_is_nameX(e, AA_LIST, NULL, "hats")) {
> > +		error_string = "Invalid profile hat";
> > +		while (!aa_is_nameX(e, AA_LISTEND, NULL, NULL)) {
> > +			struct aaprofile *subprofile;
> > +			subprofile = aa_activate_profile(e, error);
> > +			if (!subprofile)
> > +				goto fail;
> > +			subprofile->parent = profile;
> > +			list_add(&subprofile->list, &profile->sub);
> > +		}
> > +	}
> > +
> > +	error_string = "Invalid end of profile";
> > +	AA_READ_X(e, AA_STRUCTEND, NULL, NULL);
> > +
> > +	return profile;
> 
> Is this kind of transltion neccessary?

Don't understand. Please expand/clarify.  The code serializes the profile data 
from userspace. 

Tony
