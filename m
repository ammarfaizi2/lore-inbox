Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030589AbWJJWR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030589AbWJJWR5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030595AbWJJWR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:17:56 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:39870 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030589AbWJJWRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:17:55 -0400
Date: Tue, 10 Oct 2006 15:17:32 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, mark.fasheh@oracle.com
Subject: Re: [PATCH 1/5] Fix a module count leak.
Message-ID: <20061010221732.GL7911@ca-server1.us.oracle.com>
Mail-Followup-To: Chandra Seetharaman <sekharan@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
	mark.fasheh@oracle.com
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010182049.20990.84496.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010182049.20990.84496.sendpatchset@localhost.localdomain>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Obviously a bug.  I've pulled it into my tree and it should appear in
OCFS2's ALL branch very shortly.

Joel

On Tue, Oct 10, 2006 at 11:20:49AM -0700, Chandra Seetharaman wrote:
> check_perm() does not drop the reference to the module when kmalloc()
> failure occurs. This patch fixes the problem.
> 
> Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
> --
> 
>  fs/configfs/file.c |   16 +++++++++-------
>  1 files changed, 9 insertions(+), 7 deletions(-)
> 
> Index: linux-2.6.18/fs/configfs/file.c
> ===================================================================
> --- linux-2.6.18.orig/fs/configfs/file.c
> +++ linux-2.6.18/fs/configfs/file.c
> @@ -275,14 +275,15 @@ static int check_perm(struct inode * ino
>  	 * it in file->private_data for easy access.
>  	 */
>  	buffer = kmalloc(sizeof(struct configfs_buffer),GFP_KERNEL);
> -	if (buffer) {
> -		memset(buffer,0,sizeof(struct configfs_buffer));
> -		init_MUTEX(&buffer->sem);
> -		buffer->needs_read_fill = 1;
> -		buffer->ops = ops;
> -		file->private_data = buffer;
> -	} else
> +	if (!buffer) {
>  		error = -ENOMEM;
> +		goto Enomem;
> +	}
> +	memset(buffer,0,sizeof(struct configfs_buffer));
> +	init_MUTEX(&buffer->sem);
> +	buffer->needs_read_fill = 1;
> +	buffer->ops = ops;
> +	file->private_data = buffer;
>  	goto Done;
>  
>   Einval:
> @@ -290,6 +291,7 @@ static int check_perm(struct inode * ino
>  	goto Done;
>   Eaccess:
>  	error = -EACCES;
> + Enomem:
>  	module_put(attr->ca_owner);
>   Done:
>  	if (error && item)
> 
> -- 
> 
> ----------------------------------------------------------------------
>     Chandra Seetharaman               | Be careful what you choose....
>               - sekharan@us.ibm.com   |      .......you may get it.
> ----------------------------------------------------------------------

-- 

"I almost ran over an angel
 He had a nice big fat cigar.
 'In a sense,' he said, 'You're alone here
 So if you jump, you'd best jump far.'"

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
