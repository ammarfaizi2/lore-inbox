Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbVDAMbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbVDAMbu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 07:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbVDAMbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 07:31:50 -0500
Received: from apate.telenet-ops.be ([195.130.132.57]:10928 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262728AbVDAMbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 07:31:46 -0500
Date: Fri, 1 Apr 2005 14:31:32 +0200
From: Smets Jan <jan@smets.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] possible bug in quota format v2 support
Message-ID: <20050401123132.GA26835@smets.cx>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <424BFA24.6040607@clusterfs.com> <20050331142155.GB8008@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20050331142155.GB8008@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-03-31 16:21:55 (+0200), Jan Kara <jack@suse.cz> wrote:
>   Hello,
> 
> > I'm afraid that there is a bug in quota format v2 delete qentry.
> > (The root block shouldn't be put into free blk list even if there isn't
> > any entry in quota file, right?)
> > 
> > This one line patch may fix it.
>   Such case should not actually occur in normal operation but I agree
> that with your patch the code will handle errors more gracefuly. Your
> patch seems to have wrapped lines and substituted tabs for spaces
> (please try to persuade your mail agent not to wrap lines and substitute
> tabs next time or just send the patch as an attachment) so I rediffed it
> - the result is attached. Andrew please apply the attached patch.
> 
> 					Thanks for spotting it
> 								Honza
> 						
> -- 
> Jan Kara <jack@suse.cz>
> SuSE CR Labs

> Don't put root block of quota tree to the free list (when quota file is completely
> empty). That should not actually happen anyway (somebody should get accounted for
> the filesystem root and so quota file should never be empty) but better prevent it
> here than solve magical quota file corruption...
> 
> From: Niu YaWei <niu@clusterfs.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> 
> diff -rupX /home/jack/.kerndiffexclude linux-2.6.11/fs/quota_v2.c linux-2.6.11-v2fix/fs/quota_v2.c
> --- linux-2.6.11/fs/quota_v2.c	2005-03-03 18:58:30.000000000 +0100
> +++ linux-2.6.11-v2fix/fs/quota_v2.c	2005-03-31 15:51:51.000000000 +0200
> @@ -503,7 +503,8 @@ static int remove_tree(struct dquot *dqu
>  		int i;
>  		ref[GETIDINDEX(dquot->dq_id, depth)] = cpu_to_le32(0);
>  		for (i = 0; i < V2_DQBLKSIZE && !buf[i]; i++);	/* Block got empty? */
> -		if (i == V2_DQBLKSIZE) {
> +		/* Don't put the root block into the free block list */
> +		if (i == V2_DQBLKSIZE && *blk != V2_DQTREEOFF) {
>  			put_free_dqblk(sb, type, buf, *blk);
>  			*blk = 0;
>  		}

Well done Jan :-) 

I've posted an update of my problem with the quotaoff oops:

http://bugme.osdl.org/show_bug.cgi?id=2698

The BUG is at fs/dquot.c:425 

Thanks again.


-- 
Smets Jan
jan@smets.cx

