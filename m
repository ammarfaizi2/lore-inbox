Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbTBTMo2>; Thu, 20 Feb 2003 07:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbTBTMoL>; Thu, 20 Feb 2003 07:44:11 -0500
Received: from ns.suse.de ([213.95.15.193]:46865 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265368AbTBTMnK>;
	Thu, 20 Feb 2003 07:43:10 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Labs, SuSE Linux AG
To: Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [RFC/PATCH] ACLs over NFS: Necessary changes in the core NFS code
Date: Thu, 20 Feb 2003 13:53:10 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Olaf Kirch <okir@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_MGYLM0AB9Q6DIOL2OB0I"
Message-Id: <200302201353.10863.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_MGYLM0AB9Q6DIOL2OB0I
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I have implemented Sun's NFS ACL protocol, which is an extension to=20
NFSv3 that allows to manipulate POSIX ACLs over NFS mounts. Before that=20
can be integrated a few changes to the NFS/RPC layer are needed:

* The NFS ACL protocol binds to the same port as the NFS protocol. The=20
kernel NFS doesn't yet support multiple RPC programs on the same port.

* The RPC client does not properly report missing program/procedure=20
information to its caller.

* Particularly for the NFS ACL protocol, the -ENOTSUPP and -ENOPNOTSUPP=20
errors are not converted into NFS errors.

The attached patch implements these missing bits.

I am not certain about how to best handle the clnt->cl_xprt transport=20
endpoints: The patch uses a reference count in struct rpc_xprt to keep=20
track of how many clients are using a certain endpoint. This is the=20
least intrusive change; it may make more sense to handle this=20
explicitly in the RPC clients. What do you think?

(The attached patch is against 2.5.62; this and a 2.4.21pre4 patch can=20
be found at <http://www.suse.de/~agruen/acl/nfs/>.)

Cheers,
Andreas.

--------------Boundary-00=_MGYLM0AB9Q6DIOL2OB0I
Content-Type: text/x-diff;
  charset="us-ascii";
  name="nfs-multiple-programs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="nfs-multiple-programs.diff"

diff -Nur linux-2.5.62.orig/fs/lockd/svc.c linux-2.5.62/fs/lockd/svc.c
--- linux-2.5.62.orig/fs/lockd/svc.c	2003-02-17 23:56:20.000000000 +0100
+++ linux-2.5.62/fs/lockd/svc.c	2003-02-20 13:16:46.000000000 +0100
@@ -380,6 +380,7 @@
 
 #define NLM_NRVERS	(sizeof(nlmsvc_version)/sizeof(nlmsvc_version[0]))
 struct svc_program	nlmsvc_program = {
+	.pg_next	= NULL,			/* last program */
 	.pg_prog	= NLM_PROGRAM,		/* program number */
 	.pg_nvers	= NLM_NRVERS,		/* number of entries in nlmsvc_version */
 	.pg_vers	= nlmsvc_version,	/* version table */
diff -Nur linux-2.5.62.orig/fs/nfsd/nfsproc.c linux-2.5.62/fs/nfsd/nfsproc.c
--- linux-2.5.62.orig/fs/nfsd/nfsproc.c	2003-02-17 23:56:11.000000000 +0100
+++ linux-2.5.62/fs/nfsd/nfsproc.c	2003-02-20 12:56:37.000000000 +0100
@@ -592,6 +592,8 @@
 #endif
 		{ nfserr_stale, -ESTALE },
 		{ nfserr_dropit, -ENOMEM },
+		{ nfserr_notsupp, -ENOTSUP },
+		{ nfserr_notsupp, -ENOTSUPP },
 		{ -1, -EIO }
 	};
 	int	i;
diff -Nur linux-2.5.62.orig/fs/nfsd/nfssvc.c linux-2.5.62/fs/nfsd/nfssvc.c
--- linux-2.5.62.orig/fs/nfsd/nfssvc.c	2003-02-17 23:56:16.000000000 +0100
+++ linux-2.5.62/fs/nfsd/nfssvc.c	2003-02-20 13:16:26.000000000 +0100
@@ -335,10 +335,11 @@
 
 #define NFSD_NRVERS		(sizeof(nfsd_version)/sizeof(nfsd_version[0]))
 struct svc_program		nfsd_program = {
+	.pg_next		= NULL,			/* last program */
 	.pg_prog		= NFS_PROGRAM,		/* program number */
 	.pg_nvers		= NFSD_NRVERS,		/* nr of entries in nfsd_version */
 	.pg_vers		= nfsd_version,		/* version table */
 	.pg_name		= "nfsd",		/* program name */
 	.pg_class		= "nfsd",		/* authentication class */
-	.pg_stats		= &nfsd_svcstats,	/* version table */
+	.pg_stats		= &nfsd_svcstats,	/* rpc statistics */
 };
diff -Nur linux-2.5.62.orig/include/linux/sunrpc/svc.h linux-2.5.62/include/linux/sunrpc/svc.h
--- linux-2.5.62.orig/include/linux/sunrpc/svc.h	2003-02-17 23:56:16.000000000 +0100
+++ linux-2.5.62/include/linux/sunrpc/svc.h	2003-02-20 12:30:38.000000000 +0100
@@ -225,9 +225,10 @@
 };
 
 /*
- * RPC program
+ * List of RPC programs on the same transport endpoint
  */
 struct svc_program {
+	struct svc_program *	pg_next;	/* other programs */
 	u32			pg_prog;	/* program number */
 	unsigned int		pg_lovers;	/* lowest version */
 	unsigned int		pg_hivers;	/* lowest version */
diff -Nur linux-2.5.62.orig/include/linux/sunrpc/xprt.h linux-2.5.62/include/linux/sunrpc/xprt.h
--- linux-2.5.62.orig/include/linux/sunrpc/xprt.h	2003-02-17 23:56:42.000000000 +0100
+++ linux-2.5.62/include/linux/sunrpc/xprt.h	2003-02-20 12:51:35.000000000 +0100
@@ -148,6 +148,8 @@
 				nocong	   : 1,	/* no congestion control */
 				resvport   : 1, /* use a reserved port */
 				stream     : 1;	/* TCP */
+	unsigned int		clients;	/* Number of clients using
+						   this transport */
 
 	/*
 	 * State of TCP reply receive stuff
diff -Nur linux-2.5.62.orig/net/sunrpc/clnt.c linux-2.5.62/net/sunrpc/clnt.c
--- linux-2.5.62.orig/net/sunrpc/clnt.c	2003-02-17 23:56:12.000000000 +0100
+++ linux-2.5.62/net/sunrpc/clnt.c	2003-02-20 12:54:30.000000000 +0100
@@ -117,6 +117,8 @@
 	memset(clnt, 0, sizeof(*clnt));
 	atomic_set(&clnt->cl_users, 0);
 
+	xprt->clients++;
+
 	clnt->cl_xprt     = xprt;
 	clnt->cl_procinfo = version->procs;
 	clnt->cl_maxproc  = version->nrprocs;
@@ -209,7 +211,7 @@
 		clnt->cl_auth = NULL;
 	}
 	rpc_rmdir(clnt->cl_pathname);
-	if (clnt->cl_xprt) {
+	if (clnt->cl_xprt && !(--clnt->cl_xprt->clients)) {
 		xprt_destroy(clnt->cl_xprt);
 		clnt->cl_xprt = NULL;
 	}
@@ -939,6 +941,14 @@
 		return p;
 	case RPC_GARBAGE_ARGS:
 		break;			/* retry */
+	case RPC_PROG_UNAVAIL:
+		dprintk(KERN_WARNING "RPC: unknown program\n");
+		rpc_exit(task, -ENOSYS);
+		return NULL;
+	case RPC_PROC_UNAVAIL:
+		dprintk(KERN_WARNING "RPC: unknown procedure\n");
+		rpc_exit(task, -ENOSYS);
+		return NULL;
 	default:
 		printk(KERN_WARNING "call_verify: server accept status: %x\n", n);
 		/* Also retry */
diff -Nur linux-2.5.62.orig/net/sunrpc/svc.c linux-2.5.62/net/sunrpc/svc.c
--- linux-2.5.62.orig/net/sunrpc/svc.c	2003-02-17 23:56:58.000000000 +0100
+++ linux-2.5.62/net/sunrpc/svc.c	2003-02-20 12:55:43.000000000 +0100
@@ -319,8 +319,10 @@
 		goto dropit;
 	}
 		
-	progp = serv->sv_program;
-	if (prog != progp->pg_prog)
+	for (progp = serv->sv_program; progp; progp = progp->pg_next)
+		if (prog == progp->pg_prog)
+			break;
+	if (progp == NULL)
 		goto err_bad_prog;
 
 	if (vers >= progp->pg_nvers ||
@@ -433,8 +435,7 @@
 
 err_bad_prog:
 #ifdef RPC_PARANOIA
-	if (prog != 100227 || progp->pg_prog != 100003)
-		printk("svc: unknown program %d (me %d)\n", prog, progp->pg_prog);
+	printk("svc: unknown program %d\n", prog);
 	/* else it is just a Solaris client seeing if ACLs are supported */
 #endif
 	serv->sv_stats->rpcbadfmt++;

--------------Boundary-00=_MGYLM0AB9Q6DIOL2OB0I--

