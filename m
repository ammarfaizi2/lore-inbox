Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWC1Nu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWC1Nu2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 08:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWC1Nu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 08:50:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5016 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932215AbWC1NuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 08:50:25 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060328130533.GB19243@sergelap.austin.ibm.com> 
References: <20060328130533.GB19243@sergelap.austin.ibm.com> 
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] split security_key_alloc into two functions 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 28 Mar 2006 14:50:06 +0100
Message-ID: <4452.1143553806@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn <serue@us.ibm.com> wrote:

> The security_key_alloc() function acted as both an authorizer and
> security structure allocation function.  These roles should be
> separated.  There are two reasons for this.

Your patch is part of what I had originally, but this was mildly objected to
because SE Linux didn't care, so I dropped the post function for later
resurrection.  See the email thread rooted on:

	| From: David Howells <dhowells@redhat.com>
	| To: torvalds@osdl.org, akpm@osdl.org
	| Date: Wed, 05 Oct 2005 17:28:34 +0100
	| Cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
	| Subject: [Keyrings] [PATCH] Keys: Add LSM hooks for key management

in which I included key_post_alloc():

		/* publish the key by giving it a serial number */
		atomic_inc(&user->nkeys);
		key_alloc_serial(key);

	- error:
	+	/* let the security module know the key has been published */
	+	security_key_post_alloc(key);
	+
	+error:

I'm happy with this patch, though I'd like the comment you can see in the
above snippet to be added back into key.c too.

Note also that by the time the post function is called, it's a little late to
be authorising creation of the key since the key has been published by that
point.

Acked-By: David Howells <dhowells@redhat.com>
