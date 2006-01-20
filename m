Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWATTtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWATTtU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWATTtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:49:19 -0500
Received: from igw2.br.ibm.com ([32.104.18.25]:20957 "EHLO igw2.br.ibm.com")
	by vger.kernel.org with ESMTP id S932099AbWATTtS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:49:18 -0500
From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: Alexey Dobriyan <adobriyan@gmail.com>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       adilger@clusterfs.com, akpm@osdl.org
Subject: Re: [PATCH] ext3: Properly report backup blocks present in a group
Date: Fri, 20 Jan 2006 17:48:59 -0200
User-Agent: KMail/1.8.3
References: <20060120183721.GB25386@br.ibm.com> <20060120200106.GA8707@mipter.zuzino.mipt.ru>
In-Reply-To: <20060120200106.GA8707@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601201749.00043.glommer@br.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sexta 20 Janeiro 2006 18:01, você escreveu:
> On Fri, Jan 20, 2006 at 06:37:21PM +0000, Glauber de Oliveira Costa wrote:
> > In filesystems with the meta block group flag on, ext3_bg_num_gdb()
> > fails to report the correct number of blocks used to store the group
> > descriptor backups in a given group. It happens because meta_bg
> > follows a different logic from the original ext3 backup placement
> > in groups multiples of 3, 5 and 7.
> >
> > --- a/fs/ext3/balloc.c
> > +++ b/fs/ext3/balloc.c
> > @@ -1510,9 +1529,15 @@ int ext3_bg_has_super(struct super_block
> >   */
> >  unsigned long ext3_bg_num_gdb(struct super_block *sb, int group)
> >  {
> > -	if
> > (EXT3_HAS_RO_COMPAT_FEATURE(sb,EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER)&& -	 
> >   !ext3_group_sparse(group))
> > -		return 0;
> > -	return EXT3_SB(sb)->s_gdb_count;
> > +	unsigned long first_meta_bg =
> > +		cpu_to_le32(EXT3_SB(sb)->s_es->s_first_meta_bg);
> > +	unsigned long metagroup = group / EXT3_DESC_PER_BLOCK(sb);
> > +
> > +	if (!EXT3_HAS_INCOMPAT_FEATURE(sb,EXT3_FEATURE_INCOMPAT_META_BG)
> > +			|| metagroup < first_meta_bg)
>
> 			   ^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Comparison between little-endian and host-endian variables.

I should have used le32_to_cpu() instead of cpu_to_le32() some lines above. It 
was a minor typo  error. I Will resend.

Thank you.

> > +		return ext3_bg_num_gdb_nometa(sb,group);
> > +
> > +	return ext3_bg_num_gdb_meta(sb,group);
