Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWIEMSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWIEMSc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 08:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWIEMSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 08:18:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19875 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932085AbWIEMSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 08:18:30 -0400
Subject: Re: [PATCH 09/16] GFS2: Extended attribute & ACL support
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0609041835590.28823@yvahk01.tjqt.qr>
References: <1157031403.3384.801.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609041835590.28823@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 05 Sep 2006 13:23:58 +0100
Message-Id: <1157459038.3384.1001.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-09-04 at 18:55 +0200, Jan Engelhardt wrote:
> >+#if 0
> >+	else if ((ip->i_di.di_flags & GFS2_DIF_EA_PACKED) &&
> >+		 er->er_type == GFS2_EATYPE_SYS)
> >+		return 1;
> >+#endif
> 
now removed.

> >+/**
> >+ * ea_get_unstuffed - actually copies the unstuffed data into the
> >+ *                    request buffer
> >+ * @ip:
> >+ * @ea:
> >+ * @data:
> >+ *
> >+ * Returns: errno
> >+ */
> 
> There are more of these. If you have the time, please fill in.
> 
I've filled in the remaining ones in this file so far.

> >+			*dataptr++ = cpu_to_be64((uint64_t)bh->b_blocknr);
> 
> At least on i386, this cast seems unnecessary, since
> 
> include/asm-i386/byteorder.h:
> static __inline__ __attribute_const__ __u64 ___arch__swab64(__u64 val)          
> 
> but someone else should probably prove me right/wrong.
> 
I agree, so I've removed it.

> >+	if (private)
> >+		ea_set_remove_stuffed(ip, (struct gfs2_ea_location *)private);
> 
> private is a void *, ergo nocast.
> 
ok

> >+	gfs2_glock_dq_uninit(&al->al_ri_gh);
> 
> Another Ken Preslan gem? al_ri_gh_t then.
> 
:-) It is, but it does make sense:

 The al prefix means its part of a gfs2_alloc structure
 The ri stands for "Resource Index" one of GFS2's special files which in
this case contains a list of the on-disk locations of the resource
groups (think ext2/3 block groups and you won't be too far wrong).
 The gh stands for gfs2_holder which is the structure associated with
holding a glock on something (in this case the Resource Index inode).

> >+		return (5 + (ea->ea_name_len + 1));
> ()
> 
> >+unsigned int gfs2_ea_name2type(const char *name, char **truncated_name)
> >+{
> >+	unsigned int type;
> >+
> >+	if (strncmp(name, "system.", 7) == 0) {
> >+		type = GFS2_EATYPE_SYS;
> >+		if (truncated_name)
> >+			*truncated_name = strchr(name, '.') + 1;
> 
> Since we already know where the dot is (otherwise, strncmp would have failed),
> we can omit the relookup with strchr:
> 
> 	*truncated_name = name + sizeof("system.") - 1;
> 
ok, all fixed. Also I noticed as soon as I did that, that it was
possible to add a bunch more const in various places, so I did that too.
I've also taken a look over the indenting which appeared a bit odd in
places and fixed up that at the same time. The patch is here:

http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=cca195c5c09b81065018dee39f4013b95bf47502

Steve.


