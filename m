Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTE3Gnz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 02:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbTE3Gnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 02:43:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35245 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263315AbTE3Gny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 02:43:54 -0400
Date: Thu, 29 May 2003 23:56:00 -0700 (PDT)
Message-Id: <20030529.235600.88007251.davem@redhat.com>
To: scrosby@cs.rice.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <oydof1l2aq3.fsf@bert.cs.rice.edu>
References: <oyd3cixc9ev.fsf@bert.cs.rice.edu>
	<20030529.232440.122068039.davem@redhat.com>
	<oydof1l2aq3.fsf@bert.cs.rice.edu>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Scott A Crosby <scrosby@cs.rice.edu>
   Date: 30 May 2003 01:46:12 -0500
   
   Its not safe to do anything like

One thing that helps here is that we don't need to provide
protection outside the realm of a single name.

This is because the hash function takes the pointer of the dentry of
the directory it is in (the parent), and contributes this into
the hash.

Back to the basic problem, using jenkins for hashing names.  You could
simply shuffle the bytes into a set of 3 32-bit words, every time
you've contributed 12 bytes (the 3 words are full) or you've finished
the string, you run a __jhash_mix(a,b,c) pass.  And you can make
init_name_hash() insert the initial random value (choosen using
get_random_bytes() right before we mount root).

After all, a string is just a variable number of u32 words.

Actually, since we can say something about the alignment of the string
pointer in the dentry case, we can simply feed this as a u32 pointer
straight into the jenkins hash.  We know the length of the string so
this is pretty easy.  Actually, the most generic version "jhash()"
handles arbitrary byte lengths and alignments.
