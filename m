Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbUKJRoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbUKJRoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 12:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUKJRoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 12:44:04 -0500
Received: from vena.lwn.net ([206.168.112.25]:29080 "HELO lwn.net")
	by vger.kernel.org with SMTP id S262023AbUKJRn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 12:43:59 -0500
Message-ID: <20041110174358.32392.qmail@lwn.net>
To: Serge Hallyn <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [RFC] [PATCH] [2/6] LSM Stacking: Add stacker LSM 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Thu, 04 Nov 2004 17:08:01 CST."
             <1099609681.2096.16.camel@serge.austin.ibm.com> 
Date: Wed, 10 Nov 2004 10:43:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without addressing the question of whether stacking modules makes sense
in the first place, I'd like to note a couple of things which caught my
eye:

> +static int stacker_register (const char *name, struct
> security_operations *ops)
> +{
> +	/* This function is the primary reason for the stacker module.
> +	   Add the stacked module (as specified by name and ops)
> +	   according to the current ordering policy. */
> +
> +	char *new_module_name;
> +	struct module_entry *new_module_entry;
> +	int namelen;
> +
> +	num_stacked_modules++;
> [...]
> +	return num_stacked_modules-1;
> +}

Unless I've missed it, you never check num_stacked_modules against
CONFIG_NUM_LSMS.  If somebody loads too many modules, they risk
overflowing all of those void * security arrays you've added to so many
kernel data structures, and thus corrupting those structures.  That, in
technical terms, would be a bummer.

In stacker_unregister(), you do:

> +	num_stacked_modules--;

What happens if you unload anything other than the last module, then
load something else?  When you return num_stacked_modules-1 to the new
module, you'll point it to a slot in those security arrays which is
already used by another module.  The result seems unlikely to improve
security.

Unless I'm simply confused?  It's happened before...

jon

