Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263502AbTDDNPu (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 08:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263515AbTDDNPu (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 08:15:50 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:35206 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263502AbTDDNM0 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 08:12:26 -0500
Date: Fri, 4 Apr 2003 15:23:53 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: david.jander@protonic.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ncpfs, kernel 2.4.18
Message-ID: <20030404132353.GA14449@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  4 Apr 03 at 14:33, David Jander wrote:

> When listing a directory with "ls", the function ncp_obtain_info() is called 
> once for each entry in that directory, plus one time for the directory itself 
> and (presumably) one time for the directory therunder (".." ?).
> If you do this for a volume-root, you are trying to get the Original 
> Name-Space of a directory under the volume, which makes the Netware-3.12 
> server bark.
> The error I am getting on the server goes like this: 
> "GetOriginalNameSpace could not find the originating name space. DOS name was 
> assumed. Use vrepair to fix this!"

Did you tried vrepair? ;-) What namespaces do you use? OS2+DOS? In that case,
can you (after you upgrade/downgrade kernel, see below) try adding -o noos2
option to the ncpmount command line, and recheck whether problem persist or
not? 

> BTW, I am also having another problem with listing the directory contents of 
> the directory where the Novell Server was mounted. I don't know if I will 
> have time to get to the ground of this though, since it looks like a problem 
> with the driver not handling i-nodes correctly with newer kernels. I get this 
> behaviour:
> -------------- CUT HERE ---------------------
> linux:/mnt/Novell # ls -l
> ls: .: Stale NFS file handle

Are you sure that you are using stock 2.4.18 kernel? This bug was introduced
by RedHat's updates, and then it found its way to 2.4.19. It should be
fixed in 2.4.20. And maybe that it will also fix error message you are
seeing on server...

There is one suspicious thing - ncp_lookup_volume lookups directory entry
always in DOS namespace, although other namespace might be used after
that. It does not cause any problems on NW4/NW5/NW6, but maybe your
NW3.12 is too picky about that. So if simple upgrading your kernel to 2.4.20
will not help, try patch below. But it needs testing with all NetWare
versions, as documentation talks about magic value 'Jn' in 4th/5th byte
of request. If 'Jn' is supported even on NW3.11, it would be better
to use bytes 22, 0, server->name_space[volnum], 'J', 'n' in the request, 
as we do not want case sensitive volume names even under NFS namespace.
And from documentation it is not clear whether dirEntNum is returned when
there is no Jn signature in request.
						Petr Vandrovec
						vandrove@vc.cvut.cz



--- linux/fs/ncpfs/ncplib_kernel.c.orig	2003-03-31 18:58:30.000000000 +0200
+++ linux/fs/ncpfs/ncplib_kernel.c	2003-04-04 15:16:20.000000000 +0200
@@ -568,12 +568,17 @@
 
 	DPRINTK("ncp_lookup_volume: looking up vol %s\n", volname);
 
+	server->name_space[volnum] = ncp_get_known_namespace(server, volnum);
+
+	DPRINTK("lookup_vol: namespace[%d] = %d\n",
+		volnum, server->name_space[volnum]);
+
 	ncp_init_request(server);
 	ncp_add_byte(server, 22);	/* Subfunction: Generate dir handle */
-	ncp_add_byte(server, 0);	/* DOS namespace */
-	ncp_add_byte(server, 0);	/* reserved */
-	ncp_add_byte(server, 0);	/* reserved */
-	ncp_add_byte(server, 0);	/* reserved */
+	ncp_add_byte(server, server->name_space[volnum]);	/* Src & dst namespace */
+	ncp_add_byte(server, 0);	/* reserved or dst namespace if 'Jn' is below */
+	ncp_add_byte(server, 0);	/* reserved or 'J' (or 'n'?) */
+	ncp_add_byte(server, 0);	/* reserved or 'n' (or 'J'?) */
 
 	ncp_add_byte(server, 0);	/* faked volume number */
 	ncp_add_dword(server, 0);	/* faked dir_base */
@@ -586,15 +591,11 @@
 		return result;
 	}
 	memset(target, 0, sizeof(*target));
-	target->DosDirNum = target->dirEntNum = ncp_reply_dword(server, 4);
+	target->dirEntNum = ncp_reply_dword(server, 0);
+	target->DosDirNum = ncp_reply_dword(server, 4);
 	target->volNumber = volnum = ncp_reply_byte(server, 8);
 	ncp_unlock_server(server);
 
-	server->name_space[volnum] = ncp_get_known_namespace(server, volnum);
-
-	DPRINTK("lookup_vol: namespace[%d] = %d\n",
-		volnum, server->name_space[volnum]);
-
 	target->nameLen = strlen(volname);
 	memcpy(target->entryName, volname, target->nameLen+1);
 	target->attributes = aDIR;
