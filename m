Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbUCAPxA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 10:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbUCAPxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 10:53:00 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:38916 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261346AbUCAPw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 10:52:59 -0500
Date: Mon, 1 Mar 2004 12:51:26 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: Alain Fauconnet <alain@ait.ac.th>
cc: Jo Christian Buvarp <jcb@svorka.no>, Enrico Demarin <enricod@videotron.ca>,
       <linux-kernel@vger.kernel.org>, <cel@citi.umich.edu>
Subject: Re: Ibm Serveraid Problem with 2.4.25
In-Reply-To: <20040301021014.GA1270@ait.ac.th>
Message-ID: <Pine.LNX.4.44.0403011242580.4148-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 1 Mar 2004, Alain Fauconnet wrote:

> Please followup to the list when you've drawn conclusions  about  this
> issue.
> I'm holding a 2.4.25 upgrade of a busy mail server because of this.

We found out the guilty part, its the readahead modifications done by
Chuck Lever in -pre1.

The error is harmless though, you can safely move your server to 2.4.25. 
Its just trying to readahead a page beyond the end device.

The following untested patch on top of 2.4.25 should fix it:

--- mm/filemap.c.orig	2004-03-01 12:47:41.000000000 -0300
+++ mm/filemap.c	2004-03-01 12:48:30.000000000 -0300
@@ -1346,7 +1346,7 @@
 	while (ahead < max_ahead) {
 		unsigned long ra_index = raend + ahead + 1;
 
-		if (ra_index > end_index)
+		if (ra_index >= end_index)
 			break;
 		if (page_cache_read(filp, ra_index) < 0)
 			break;

