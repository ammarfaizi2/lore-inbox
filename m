Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265963AbSKBNR7>; Sat, 2 Nov 2002 08:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265964AbSKBNR6>; Sat, 2 Nov 2002 08:17:58 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:39694 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S265963AbSKBNR5>; Sat, 2 Nov 2002 08:17:57 -0500
Date: Sat, 2 Nov 2002 14:24:21 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alexander Zarochentcev <zam@namesys.com>
Cc: Hans Reiser <reiser@namesys.com>, lkml <linux-kernel@vger.kernel.org>,
       Oleg Drokin <green@namesys.com>, umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
Message-ID: <20021102132421.GJ28803@louise.pinerecords.com>
References: <3DC19F61.5040007@namesys.com> <200210312334.18146.Dieter.Nuetzel@hamburg.de> <3DC1B2FA.8010809@namesys.com> <3DC1D63A.CCAD78EF@digeo.com> <3DC1D885.6030902@namesys.com> <3DC1D9D0.684326AC@digeo.com> <3DC1DF02.7060307@namesys.com> <20021101102327.GA26306@louise.pinerecords.com> <15810.46998.714820.519167@crimson.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15810.46998.714820.519167@crimson.namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This should help:
> 
> diff -Nru a/txnmgr.c b/txnmgr.c
> --- a/txnmgr.c	Wed Oct 30 18:58:09 2002
> +++ b/txnmgr.c	Fri Nov  1 20:13:27 2002
> @@ -1917,7 +1917,7 @@
>  		return;
>  	}
>  
> -	if (!jnode_is_unformatted) {
> +	if (jnode_is_znode(node)) {
>  		if ( /**jnode_get_block(node) &&*/
>  			   !blocknr_is_fake(jnode_get_block(node))) {
>  			/* jnode has assigned real disk block. Put it into


Jup, this fixes the leak, but free space still isn't reported accurately
until after sync gets called, which I believe is a bug too.

Compare:
[reiser3]
$ pwd
/tmp
$ dd if=/dev/zero of=testfile bs=16k count=64
64+0 records in
64+0 records out
$ df /
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda1               526296    330696    195600  63% /
$ rm testfile
$ df /
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda1               526296    329672    196624  63% /
$ sync
$ df /
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda1               526296    329672    196624  63% /

[reiser4]
$ pwd
/ap/tmp
$ dd if=/dev/zero of=testfile bs=16k count=64
64+0 records in
64+0 records out
$ df /ap
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda2              1490332      1152   1489180   1% /ap
$ rm testfile
$ df /ap
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda2              1490332      1160   1489172   1% /ap
$ sync
$ df /ap
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda2              1490332       128   1490204   1% /ap

T.
