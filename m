Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbTELVHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTELVHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:07:20 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:23709 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262700AbTELVHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:07:18 -0400
Date: Mon, 12 May 2003 14:19:40 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: faith@redhat.com, <ajoshi@shell.unixbox.com>, <mc@cs.stanford.edu>
Subject: [CHECKER] One more potential user-pointer error
In-Reply-To: <Pine.GSO.4.44.0305112325140.2457-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0305121357250.7936-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Enclosed is one warning in drivers/char/drm/radeon_state.c  I've attached
a detaillsed explanation. If it is not clear, please mail me.

As always, please confirm or clarify. Thanks!

-Junfeng

---------------------------------------------------------

[BUG] function radeon_cp_dispatch_indices calls
DRM_COPY_FROM_USER_UNCHECKED on parameter 'dev_priv->sarea_priv->boxes',
implies it is a user space pointer. dev_piv->sarea_priv has type
'drm_radeon_sarea_t', where field 'drm_radeon_sarea_t.boxes' is declared
as an array. so dev_priv->sarea_priv->boxes is equivalent to
dev_priv->sarea_priv + offset of field 'boxes'. since dev_priv->sarea_priv
+ offset_of_'boxes' is tainted, dev_priv->sarea_priv is also a user-space
pointer. this pointer is deref'd several times.

/home/junfeng/linux-tainted/drivers/char/drm/radeon_state.c:1554:radeon_cp_indices:
ERROR:TAINTED:1554:1554: dereferencing tainted ptr 'dev_priv->sarea_priv'
[Callstack: ]

	prim.prim = elts.prim;
	prim.offset = 0;	/* offset from start of dma buffers */
	prim.numverts = RADEON_MAX_VB_VERTS; /* duh */
	prim.vc_format = dev_priv->sarea_priv->vc_format;


Error --->
	radeon_cp_dispatch_indices( dev, buf, &prim,
				   dev_priv->sarea_priv->boxes,
				   dev_priv->sarea_priv->nbox );
	if (elts.discard) {
---------------------------------------------------------
[BUG]

/home/junfeng/linux-tainted/drivers/char/drm/radeon_state.c:1773:radeon_cp_vertex2:
ERROR:TAINTED:1773:1773: dereferencing tainted ptr 'sarea_priv'
[Callstack: ]


		if ( prim.prim & RADEON_PRIM_WALK_IND ) {
			tclprim.offset = prim.numverts * 64;
			tclprim.numverts = RADEON_MAX_VB_VERTS; /* duh */


Error --->
			radeon_cp_dispatch_indices( dev, buf, &tclprim,
						    sarea_priv->boxes,
						    sarea_priv->nbox);
		} else {
---------------------------------------------------------
[BUG]

/home/junfeng/linux-tainted/drivers/char/drm/radeon_state.c:1454:radeon_cp_vertex:
ERROR:TAINTED:1454:1454: dereferencing tainted ptr 'dev_priv->sarea_priv'
[Callstack: ]

		prim.finish = vertex.count; /* unused */
		prim.prim = vertex.prim;
		prim.numverts = vertex.count;
		prim.vc_format = dev_priv->sarea_priv->vc_format;


Error --->
		radeon_cp_dispatch_vertex( dev, buf, &prim,
					   dev_priv->sarea_priv->boxes,
					   dev_priv->sarea_priv->nbox );
	}


