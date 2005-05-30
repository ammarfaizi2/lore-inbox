Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVE3Lqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVE3Lqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 07:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVE3Lqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 07:46:35 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:17794 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261445AbVE3Lqc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 07:46:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pq0hCHfiq/FRsjOdz5G5JHhiLmUvLhu3b1nOiLQri6owRMIs3DlSb4Mqyfi+5/7vTdqb4qH4k5PKPFqMc1DWiZ8MyOI7cj18gEGo1d6hgiYHywyoiaomIZ2Wy93Yu2vKwrdRUvPmtgDjZlGEg2IpkiaNOBoQhAvTLJgm5AdR/90=
Message-ID: <84144f0205053004468dc9a1b@mail.gmail.com>
Date: Mon, 30 May 2005 14:46:31 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: review of ocfs2
Cc: wim.coekaerts@oracle.com, mark.fasheh@oracle.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, suparna@in.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <20050530112101.GF15326@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050530112101.GF15326@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/30/05, Andi Kleen <ak@suse.de> wrote:
> +static int ocfs2_do_request_vote(ocfs_super *osb,
> +                                u64 blkno,
> +                                unsigned int generation,
> +                                enum ocfs2_vote_request type,
> +                                int orphaned_slot,
> +                                struct ocfs2_net_response_cb *callback)
> ...
> +       request = kmalloc(sizeof(*request), GFP_KERNEL);
> +       if (!request) {
> +               status = -ENOMEM;
> +               mlog_errno(status);
> +               goto bail;
> +       }
> +       memset(request, 0, sizeof(*request));
> 
> kcalloc

Actually, the latest preferred form for

       kcalloc(1, sizeof(*p), GFP_KERNEL)

is the following (as suggested by Al Viro):

	request = kmalloc(sizeof(*request), GFP_KERNEL);
	if (!request) {
		status = -ENOMEM;
		mlog_errno(status);
		goto bail;
	}
	*request = (ocfs2_vote_msg) { .md1.v_generic1 = htonl(priv) };
	hdr = &request->v_hdr;

	response_id = ocfs2_new_response_id(osb);

	*hdr = (ocfs2_msg_hdr) {
		.h_response_id = htonl(response_id);
		.h_request = htonl(type);
		.h_blkno = cpu_to_be64(blkno);
		.h_generation = htonl(generation);
		.h_node_num = htonl((unsigned int) osb->node_num)
	};

                   Pekka
