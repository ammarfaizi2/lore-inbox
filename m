Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265162AbUEYWqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbUEYWqu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265164AbUEYWqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:46:37 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:9090 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S265115AbUEYWqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:46:32 -0400
Date: Tue, 25 May 2004 18:46:13 -0400
To: Rob Landley <rob@landley.net>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040525224613.GA7647@delft.aura.cs.cmu.edu>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <20040511100232.GA31673@wohnheim.fh-wedel.de> <20040511140853.GT24211@delft.aura.cs.cmu.edu> <200405211823.12230.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405211823.12230.rob@landley.net>
User-Agent: Mutt/1.5.6i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 06:23:12PM -0500, Rob Landley wrote:
> >     /* are we copying the entire source file? */
> >     if (*ppos != 0 || count != in_file->f_dentry->d_inode->i_size)
> > 	goto copy_local;
> 
> Is there a race condition for i_size to change between the api getting called 
> and the copy being done?  More to the point, is there some way to specify a 
> count of -1 or something to easily say "to end of file"?

I don't think so, what does the existing sendfile to a socket
implementation do?

Sure there is something you could call a race, but it doesn't seem all
that serious to me. If someone writes to the source file a couple of
seconds after the copy completes we would get the exact same situation.

The only problem here is that it is possible for the write to arrive
between the stat of the source file to get the number of bytes we want
to copy and the actual sendfile call. That would invalidate the cached
inode data and by the time call sendfile the example code falls back to
a local copy operation because count != i_size.

But if the filesystem provided a more powerful copy operation than just
copy whole file A to file B it could actually do what the user asked for
without needing to fall back on the local copy operation.

An application that wants to make sure the source file is not modified
before, during or after the copy operation, both by the local client and
possibly by any remote clients, probably should lock it with flock or
fcntl.

Jan

