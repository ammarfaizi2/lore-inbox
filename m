Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264228AbUD0Ry2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbUD0Ry2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 13:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbUD0Ry2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 13:54:28 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:43401 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264228AbUD0RyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 13:54:23 -0400
Subject: Re: [PATCH 11/11] nfs-acl
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1083087180.19655.263.camel@winden.suse.de>
References: <1082975215.3295.81.camel@winden.suse.de>
	 <1083013819.15282.56.camel@lade.trondhjem.org>
	 <1083087180.19655.263.camel@winden.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083088460.2616.65.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Apr 2004 13:54:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 13:33, Andreas Gruenbacher wrote:

> We can share the same socket, but the code gets slightly messier. How
> about sharing the whole struct rpc_xprt (incremental patch)?

How about doing it as I suggested, using rpc_clone_client() instead?

You'll need to add

void rpc_change_program(struct rpc_client *clnt, struct rpc_program *program, int vers)
{
	struct rpc_version *version;

	BUG_ON(vers >= program->nrvers || !(version = program->version[vers]));
	version = &program->version[vers];
	clnt->cl_procinfo = version->procs;
	clnt->cl_maxproc = version->nrprocs;
	clnt->cl_protname = program->name;
	clnt->cl_prog = program->number;
	clnt->cl_vers = version->number;
	clnt->cl_stats = program->stats
}

...but that will allow you to do the whole process of creating the ACL
RPC client in 2 lines:

	struct rpc_client *aclclnt = rpc_clone_client(server->client);
	rpc_change_program(aclclnt, &nfsacl_program, 1);


...and hey presto, you have something that shares both the
authentication cache and the socket with the NFS client.

Cheers,
  Trond
