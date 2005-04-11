Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVDKR4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVDKR4C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 13:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVDKR4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 13:56:02 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:31920 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261863AbVDKRzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 13:55:46 -0400
Subject: Re: Fw: 2.6.12-rc2-mm3
From: Steve French <smfltc@us.ibm.com>
To: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Cc: benoit.boissinot@ens-lyon.org, akpm@osdl.com
In-Reply-To: <OF2CD78710.823AD236-ON87256FE0.0061CA94-86256FE0.0061CFC2@us.ibm.com>
References: <OF2CD78710.823AD236-ON87256FE0.0061CA94-86256FE0.0061CFC2@us.ibm.com>
Content-Type: text/plain; charset=windows-1251
Organization: IBM - Linux Technology Center
Message-Id: <1113238235.2792.4529.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Apr 2005 11:50:35 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last night I made a similar patch to the cifs bk tree and will be
testing it on ppc as soon as I can track down a free one today (it
tested fine last night on intel).  Patch is at:

http://cifs.bkbits.net:8080/linux-2.5cifs/gnupatch@4259f2138nVCJQt3SmaZowdXd8KB7A

Thanks.










> On Mon, Apr 11, 2005 at 01:25:32AM -0700, Andrew Morton wrote:
> > Changes since 2.6.12-rc2-mm2:
> > 
> > 
> >  bk-cifs.patch
> 
> 
> The following patch correct an error in bk-cifs:
> 
> fs/cifs/misc.c: In function ‘cifs_convertUCSpath’:
> fs/cifs/misc.c:546: error: case label does not reduce to an integer
> constant
> fs/cifs/misc.c:549: error: case label does not reduce to an integer
> constant
> fs/cifs/misc.c:552: error: case label does not reduce to an integer
> constant
> fs/cifs/misc.c:561: error: case label does not reduce to an integer
> constant
> fs/cifs/misc.c:564: error: case label does not reduce to an integer
> constant
> fs/cifs/misc.c:567: error: case label does not reduce to an integer
> constant
> 
> The utilisations of UNI_* constants show that it is should in cpu
> format:
> 
> for example line 542, src_char is converted in cpu_format:
>               src_char = le16_to_cpu(source[i]);
>                        switch (src_char) {
>         ...
> case UNI_COLON:
> ...
> 
> or line 610, it is unlikely that you want to have
> cpu_to_le16(cpu_to_le16(x)):
> target[j] = cpu_to_le16(UNI_COLON);
> 
> the following patch fixes it.
> 
> Signed-Off-By: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
> 
> 
> --- ./fs/cifs/misc.c.orig 2005-04-11 19:18:11.000000000 +0200
> +++ ./fs/cifs/misc.c 2005-04-11 19:18:30.000000000 +0200
> @@ -519,13 +519,13 @@ dump_smb(struct smb_hdr *smb_buf, int sm
> /* Windows maps these to the user defined 16 bit Unicode range since
> they are
>    reserved symbols (along with \ and /), otherwise illegal to store
>    in filenames in NTFS */
> -#define UNI_ASTERIK     cpu_to_le16('*' + 0xF000)
> -#define UNI_QUESTION    cpu_to_le16('?' + 0xF000)
> -#define UNI_COLON       cpu_to_le16(':' + 0xF000)
> -#define UNI_GRTRTHAN    cpu_to_le16('>' + 0xF000)
> -#define UNI_LESSTHAN    cpu_to_le16('<' + 0xF000)
> -#define UNI_PIPE        cpu_to_le16('|' + 0xF000)
> -#define UNI_SLASH       cpu_to_le16('\\' + 0xF000)
> +#define UNI_ASTERIK     ('*' + 0xF000)
> +#define UNI_QUESTION    ('?' + 0xF000)
> +#define UNI_COLON       (':' + 0xF000)
> +#define UNI_GRTRTHAN    ('>' + 0xF000)
> +#define UNI_LESSTHAN    ('<' + 0xF000)
> +#define UNI_PIPE        ('|' + 0xF000)
> +#define UNI_SLASH       ('\\' + 0xF000)
> 
> /* Convert 16 bit Unicode pathname from wire format to string in
> current code
>    page.  Conversion may involve remapping up the seven characters
> that are

