Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWDUSmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWDUSmW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 14:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWDUSmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 14:42:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25796 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751296AbWDUSmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 14:42:21 -0400
Date: Fri, 21 Apr 2006 20:41:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 6/11] security: AppArmor - Userspace interface
Message-ID: <20060421184149.GA2078@elf.ucw.cz>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419174954.29149.80464.sendpatchset@ermintrude.int.wirex.com> <20060420213943.GD2360@ucw.cz> <20060421180115.GB740@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421180115.GB740@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +/**
> > > + * aa_activate_profile - unpack a serialized profile
> > > + * @e: serialized data extent information
> > > + * @error: error code returned if unpacking fails
> > > + */
> > > +static struct aaprofile *aa_activate_profile(struct aa_ext *e, ssize_t *error)
> > > +{
> > > +	struct aaprofile *profile = NULL;
> > > +	const char *rulename = "";
> > > +	const char *error_string = "Invalid Profile";
> > > +
> > > +	*error = -EPROTO;
> > > +
> > > +	profile = alloc_aaprofile();
> > > +	if (!profile) {
> > > +		error_string = "Could not allocate profile";
> > > +		*error = -ENOMEM;
> > > +		goto fail;
> > > +	}
> > > +
> > > +	/* check that we have the right struct being passed */
> > > +	AA_READ_X(e, AA_STRUCT, NULL, "profile");
> > > +	AA_READ_X(e, AA_DYN_STRING, &profile->name, NULL);
> > > +
> > > +	error_string = "Invalid flags";
> > > +	/* per profile debug flags (debug, complain, audit) */
> > > +	AA_READ_X(e, AA_STRUCT, NULL, "flags");
> > > +	AA_READ_X(e, AA_U32, &(profile->flags.debug), "profile.flags.debug");
> > > +	AA_READ_X(e, AA_U32, &(profile->flags.complain),
> > > +		  "profile.flags.complain");
> > > +	AA_READ_X(e, AA_U32, &(profile->flags.audit), "profile.flags.audit");
> > > +	AA_READ_X(e, AA_STRUCTEND, NULL, NULL);
> > > +
> > > +	error_string = "Invalid capabilities";
> > > +	AA_READ_X(e, AA_U32, &(profile->capabilities), "profile.capabilities");
> > > +
> > > +	/* get the file entries. */
> > > +	AA_ENTRY_LIST("pgent");		/* pcre rules */
> > > +	AA_ENTRY_LIST("sgent");		/* simple globs */
> > > +	AA_ENTRY_LIST("fent");		/* regular file entries */
> > > +
> > > +	/* get the net entries */
> > > +	if (aa_is_nameX(e, AA_LIST, NULL, "net")) {
> > > +		error_string = "Invalid net entry";
> > > +		while (!aa_is_nameX(e, AA_LISTEND, NULL, NULL)) {
> > > +			if (!aa_activate_net_entry(e))
> > > +				goto fail;
> > > +		}
> > > +	}
> > > +	rulename = "";
> > > +
> > > +	/* get subprofiles */
> > > +	if (aa_is_nameX(e, AA_LIST, NULL, "hats")) {
> > > +		error_string = "Invalid profile hat";
> > > +		while (!aa_is_nameX(e, AA_LISTEND, NULL, NULL)) {
> > > +			struct aaprofile *subprofile;
> > > +			subprofile = aa_activate_profile(e, error);
> > > +			if (!subprofile)
> > > +				goto fail;
> > > +			subprofile->parent = profile;
> > > +			list_add(&subprofile->list, &profile->sub);
> > > +		}
> > > +	}
> > > +
> > > +	error_string = "Invalid end of profile";
> > > +	AA_READ_X(e, AA_STRUCTEND, NULL, NULL);
> > > +
> > > +	return profile;
> > 
> > Is this kind of transltion neccessary?
> 
> Don't understand. Please expand/clarify.  The code serializes the profile data 
> from userspace. 

Yes, and it looks quite complex; would it be possible to get rid of
this serializing code? Could some existing infrastructure be used? One
file per value? Just pass the structure and make sure userspace is
matched to kernel? Something else?

								Pavel
-- 
Thanks for all the (sleeping) penguins.
