Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTEZRyO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbTEZRyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:54:14 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17355
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262018AbTEZRyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:54:13 -0400
Subject: Re: Linux 2.4.21-rc3 - ipmi unresolved
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <28098.1053849441@ocs3.intra.ocs.com.au>
References: <28098.1053849441@ocs3.intra.ocs.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053968924.16695.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 May 2003 18:08:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-05-25 at 08:57, Keith Owens wrote:
> I would go so far as to say that no XXX_notifier_list should be
> exported, that includes notifier_chain_register() itself.  If a module
> needs to be notified then it should have glue code in the main kernel
> that does try_inc_mod_count() on the module before calling any module
> functions.

That would be mindbogglingly ugly. Unfortunately Rusty has still only
half solved the module problem because modules are refcounted as an
"entity" not the module info and the module code/data split into two.

Ie I can't unload a module that has module object references because we
have no way to seperate "I'm talking about module xyz" and "I'm jumping
into module xyz". That IMHO is what is causing much of the remaining
mess.

Were they split then I could safely take a module object reference in
the notifiers and have

	try_inc_mod_count()

do the right thing passed a module handle to a module that is unloaded
but has object references left.

