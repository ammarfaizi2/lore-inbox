Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbWJ2Ngi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbWJ2Ngi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 08:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWJ2Ngh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 08:36:37 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:65383 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965217AbWJ2Ngg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 08:36:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=jckLdGk3l3ADhPXH8bk9B3CNN9XONAgP1zLurhy5/CSb6S60s69FBmtt9/+g+6LKVK6uxnht/sdp96LeRa3iYfPVqIsCh4V1t6Sf1wo+SFfRKzF//wdP4ZopQXPZuI5Qsu0QnB/D5k69kMlOrRfb4m4P2/KXQ9GSGozG2iCVtgk=
Date: Sun, 29 Oct 2006 22:37:00 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       Olaf Kirch <okir@monad.swb.de>
Subject: [PATCH 1/2] sunrpc: add missing spin_unlock
Message-ID: <20061029133700.GA10295@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	Olaf Kirch <okir@monad.swb.de>
References: <20061028185554.GM9973@localhost> <20061029133551.GA10072@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061029133551.GA10072@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

auth_domain_put() forgot to unlock acquired spinlock.

Cc: Olaf Kirch <okir@monad.swb.de>
Cc: Andy Adamson <andros@citi.umich.edu>
Cc: J. Bruce Fields <bfields@citi.umich.edu>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Index: work-fault-inject/net/sunrpc/svcauth.c
===================================================================
--- work-fault-inject.orig/net/sunrpc/svcauth.c
+++ work-fault-inject/net/sunrpc/svcauth.c
@@ -126,6 +126,7 @@ void auth_domain_put(struct auth_domain 
 	if (atomic_dec_and_lock(&dom->ref.refcount, &auth_domain_lock)) {
 		hlist_del(&dom->hash);
 		dom->flavour->domain_release(dom);
+		spin_unlock(&auth_domain_lock);
 	}
 }
 
