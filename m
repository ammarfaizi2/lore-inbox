Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUEKPmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUEKPmU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 11:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUEKPmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 11:42:20 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:5788 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264791AbUEKPmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 11:42:17 -0400
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of
	cowlinks
From: Steve French <smfltc@us.ibm.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20040511100232.GA31673@wohnheim.fh-wedel.de>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de>
	 <20040508224835.GE29255@atrey.karlin.mff.cuni.cz>
	 <20040510155359.GB16182@wohnheim.fh-wedel.de>
	 <20040510192601.GA11362@delft.aura.cs.cmu.edu>
	 <20040511100232.GA31673@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: IBM
Message-Id: <1084290049.5135.11.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 May 2004 10:40:49 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would not be helpful to take a userspace request to perform a file
(or directory) copy operation and break it into open/sendfile/close by
passing file handles to the network filesystem and have this work for
SMB/CIFS - there is no equivalent network protocol operation.  It also
makes the operation much, much harder to make atomic (since two systems
are involved) and makes error handling and recovery for network
filesystems much harder since inconsistent client and server state have
to be considered if the copy operation is broken into pieces on the
clien (it is also slower - a single copy operation on the network is the
absolute optimal case - minimizes the expensive network latency - the
roundtrip delay - open/sendfile/close sends at a minimum three times as
many but likely four with an extra lookup or two)

Currently copy file (or copy directory for that matter) as both speced
(and is implemented in various servers) in the SMB/CIFS network
filesystem protocol takes in effect four parameters (there is no handle
based file copy):

a source pathname,  and source export (actually SMB tree identifier for
a share, but in effect the same thing) 
a target pathname, and target export (actually SMB tree identifier for a
share, but in effect the same thing) 
And the shares (exports) referenced have to be on the same server

Trying to ignore the 1st file open

On Tue, 2004-05-11 at 05:02, Jörn Engel wrote:
> On Mon, 10 May 2004 15:26:02 -0400, Jan Harkes wrote:
> > On Mon, May 10, 2004 at 05:53:59PM +0200, Jörn Engel wrote:
> > > A real problem is that copyfile() has all errno's from create(),
> > > sendfile() and unlink() combined, which doesn't make error handling in
> > > userspace easy.  "It could be this, that or another error" is the kind
> > > of mess I always hated about Windows, so I should try to do a little
> > > better.
> > 
> > Well, if you leave the create and unlink up to the application and
> > simply pass open filedescriptors to copyfile... But then it would be
> > equivalent to your new sendfile.
> > 
> > Copyfile can trivially be implemented in libc. I don't see why it would
> > have to be a system call. If a network filesystem wants to optimize the
> > file copying it could do this based on the sendfile data. If source and
> > destination are within the same filesystem and we're copying the whole
> > file starting at offset 0, send a copyfile RPC.
> 
> Can you explain this to Steve?  I'm still quite clueless about network
> filesystems, but it sounded as if such an optimization was impossible
> to do in cifs without a combined create/copy/unlink_on_error system
> call.
> 
> If your suggestion works and the network filesystems can be changed to
> work independently of a struct file*, I agree with you that copyfile()
> is a stupid idea and should be forgotten.
> 
> Jörn

