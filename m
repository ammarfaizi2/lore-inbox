Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbWHIBLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbWHIBLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWHIBLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:11:20 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:43665 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030394AbWHIBLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:11:19 -0400
Subject: Re: [PATCH] CONFIG_RELOCATABLE modpost fix
From: Magnus Damm <magnus@valinux.co.jp>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       ebiederm@xmission.com
In-Reply-To: <20060808151657.GA18059@mars.ravnborg.org>
References: <20060808083307.391.45887.sendpatchset@cherry.local>
	 <20060808151657.GA18059@mars.ravnborg.org>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 10:12:52 +0900
Message-Id: <1155085973.4341.55.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Thanks for picking up the patch!

On Tue, 2006-08-08 at 17:16 +0200, Sam Ravnborg wrote:
> On Tue, Aug 08, 2006 at 05:32:11PM +0900, Magnus Damm wrote:
> > CONFIG_RELOCATABLE modpost fix
> > 
> > Run modpost on vmlinux regardless of CONFIG_MODULES. The modpost code is also
> > extended to ignore references from ".pci_fixup" to ".init.text".
> I've splitted the patch in two parts.
> First is this one (I slightly modified your version and removed trailing
> whitespaces).
> 
> 	Sam
> 
> commit 1f43a633dc485f90fddf667270179058a07b9d77
> Author: Magnus Damm <magnus@valinux.co.jp>
> Date:   Tue Aug 8 17:32:11 2006 +0900
> 
>     kbuild: ignore references from ".pci_fixup" to ".init.text"
>     
>     The modpost code is extended to ignore references
>     from ".pci_fixup" to ".init.text".
>     
>     Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index dfde0e8..5028d46 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -581,8 +581,8 @@ static int strrcmp(const char *s, const 
>   *   fromsec = .data
>   *   atsym = *driver, *_template, *_sht, *_ops, *_probe, *probe_one
>   **/
> -static int secref_whitelist(const char *tosec, const char *fromsec,
> -			    const char *atsym)
> +static int secref_whitelist(const char *modname, const char *tosec,
> +			    const char *fromsec, const char *atsym)
>  {
>  	int f1 = 1, f2 = 1;
>  	const char **s;
> @@ -618,8 +618,15 @@ static int secref_whitelist(const char *
>  	for (s = pat2sym; *s; s++)
>  		if (strrcmp(atsym, *s) == 0)
>  			f1 = 1;
> +	if (f1 && f2)
> +		return 1;
>  
> -	return f1 && f2;
> +	/* Whitelist all references from .pci_fixup section if vmlinux */
> +	if (is_vmlinux(modname)) {
> +		if ((strcmp(fromsec, ".pci_fixup") == 0) &&
> +		    (strcmp(tosec, ".init.text") == 0))
> +		return 1;
> +	}
>  }

You forget to return a value which result in the following warning:

  HOSTCC  scripts/mod/modpost.o
scripts/mod/modpost.c: In function `secref_whitelist':
scripts/mod/modpost.c:630: warning: control reaches end of non-void
function
  HOSTCC  scripts/mod/sumversion.o

Cheers,

/magnus

