Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWEIRaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWEIRaO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 13:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWEIRaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 13:30:14 -0400
Received: from ns2.suse.de ([195.135.220.15]:38053 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750752AbWEIRaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 13:30:12 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: Novell, SUSE Labs
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: GPL-only symbols issue
Date: Tue, 9 May 2006 19:31:35 +0200
User-Agent: KMail/1.9.1
Cc: Greg KH <greg@kroah.com>, Jan Beulich <jbeulich@novell.com>,
       sam@ravnborg.org, linux-kernel@vger.kernel.org
References: <445F0B6F.76E4.0078.0@novell.com> <20060509042500.GA4226@kroah.com> <1147154238.7203.62.camel@localhost>
In-Reply-To: <1147154238.7203.62.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 7874
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200605091931.35753.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 09 May 2006 07:57, Ram Pai wrote:
> On Mon, 2006-05-08 at 21:25 -0700, Greg KH wrote:
> > On Mon, May 08, 2006 at 09:12:15AM +0200, Jan Beulich wrote:
> > > Sam,
> > >
> > > would it seem reasonable a request to detect imports of GPL-only
> > > symbols by non-GPL modules also at build time rather than only at run
> > > time, and at least warn about such?

I would appreciate such a check: it avoids unnecessary errors later. See 
my proposed patch in the next message.

> > Ram has some tools that might catch this kind of thing.  He's posted his
> > scripts to lkml in the past, try looking in the archives.
>
> The patches are at
>
> http://sudhaa.com/~ram/misc/kernelpatch
>
> The patch of interest for you would be modpost.patch
> I have a script and some code that can poke into a given .ko file and
> warn against symbols that don't match what the kernel exports.

I like the extension that modpost.patch adds. Statistics gathering like your 
other patch does doesn't need to be in the mainline kernel IMVHO, but I don't 
really mind. Here is a bugfix to modpost.patch:

Index: linux-2.6.16/scripts/mod/modpost.c
===================================================================
--- linux-2.6.16.orig/scripts/mod/modpost.c
+++ linux-2.6.16/scripts/mod/modpost.c
@@ -811,8 +817,12 @@ static void read_dump(const char *fname,
 					*d != '\0')
 			goto fail;
 
-		if (!(strcmp(export, "EXPORT_GPL_ONLY")))
+		if (strcmp(export, "EXPORT_SYMBOL_GPL") == 0)
 			export_type = 1;
+		else if (strcmp(export, "EXPORT_SYMBOL") == 0)
+			export_type = 0;
+		else
+			goto fail;
 
 		if (!(mod = find_module(modname))) {
 			if (is_vmlinux(modname)) {

Andreas
