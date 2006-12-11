Return-Path: <linux-kernel-owner+w=401wt.eu-S1763072AbWLKUQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763072AbWLKUQD (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 15:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763073AbWLKUQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 15:16:03 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:47150 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763071AbWLKUQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 15:16:00 -0500
Date: Mon, 11 Dec 2006 21:16:11 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Andy Whitcroft <apw@shadowen.org>, sfrench@samba.org
Cc: Linus Torvalds <torvalds@osdl.org>, Herbert Poetzl <herbert@13thfloor.at>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
Message-ID: <20061211201611.GA20131@aepfle.de>
References: <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org> <20061211182908.GC7256@MAIL.13thfloor.at> <Pine.LNX.4.64.0612111040160.12500@woody.osdl.org> <457DAF99.4050106@shadowen.org> <20061211195628.GA19889@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061211195628.GA19889@aepfle.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, Olaf Hering wrote:

> On Mon, Dec 11, Andy Whitcroft wrote:
> 
> > I am afraid to report that this second version also fails for me, as you 
> > point out CIFS can break us if defined.  In fact we used to get away 
> > with this on my test system due to ordering magic luck, I presume the 
> > move to __initdata has triggered this.  Much as I agree that this is 
> > wrong we are still going to break people with this.
> 
> I'm looking at cifs_strtoUCS and wonder if its safe to check 'len &&
> *from'. IF it really is, the functions could snprintf to the stack and
> pass this to cifs_strtoUCS.
> 
> Quick, compile tested, patch below.
> 
> 
> Index: linux-2.6/fs/cifs/connect.c
> ===================================================================
> --- linux-2.6.orig/fs/cifs/connect.c
> +++ linux-2.6/fs/cifs/connect.c
> @@ -2070,6 +2070,7 @@ CIFSSessSetup(unsigned int xid, struct c
>  	      char session_key[CIFS_SESS_KEY_SIZE],
>  	      const struct nls_table *nls_codepage)
>  {
> +	char banner[2*32+1];
>  	struct smb_hdr *smb_buffer;
>  	struct smb_hdr *smb_buffer_response;
>  	SESSION_SETUP_ANDX *pSMB;
> @@ -2135,6 +2136,8 @@ CIFSSessSetup(unsigned int xid, struct c
>  	memcpy(bcc_ptr, (char *) session_key, CIFS_SESS_KEY_SIZE);
>  	bcc_ptr += CIFS_SESS_KEY_SIZE;
>  
> +	snprintf(banner, sizeof(banner), "%s version %s", utsname()->sysname,
> +		utsname()->release);
>  	if (ses->capabilities & CAP_UNICODE) {
>  		if ((long) bcc_ptr % 2) { /* must be word aligned for Unicode */
>  			*bcc_ptr = 0;
> @@ -2160,12 +2163,8 @@ CIFSSessSetup(unsigned int xid, struct c
>  		bcc_ptr += 2 * bytes_returned;
>  		bcc_ptr += 2;
>  		bytes_returned =
> -		    cifs_strtoUCS((__le16 *) bcc_ptr, "Linux version ",
> -				  32, nls_codepage);
> -		bcc_ptr += 2 * bytes_returned;
> -		bytes_returned =
> -		    cifs_strtoUCS((__le16 *) bcc_ptr, utsname()->release,
> -				  32, nls_codepage);
> +		    cifs_strtoUCS((__le16 *) bcc_ptr, banner,
> +				  64, nls_codepage);
>  		bcc_ptr += 2 * bytes_returned;
>  		bcc_ptr += 2;
>  		bytes_returned =

new_utsname->release is 65 bytes, so with a very long uname -r, the
current code already truncates release.

Steve, is 32 a hard limit in the protocol?
