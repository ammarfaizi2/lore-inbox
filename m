Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTENJlx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 05:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTENJlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 05:41:53 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:13447 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP id S261580AbTENJlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 05:41:52 -0400
Date: Wed, 14 May 2003 11:54:28 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: David Hinds <dahinds@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, brian@debian.org
Subject: pcmcia-cs: ifuser times out in gethostbyname for empty route tables
Message-ID: <20030514095428.GA14380@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David!

[lkml: sorry for off-topic, but David is very slow on responses, and
the fix could be useful to someone
Brian: the sources are downloaded from debian-unstable]

If I try to stop pcmcia services without actually connecting to the network,
if user will hang for annoyngly long time. I narrowed the problem down
to ifuser tryng to resolve the word "Destination" (first word of the
last line of "netstat -rn" output for empty route table).

That are the second and the third hunks in the attached patch.
The first doesn't start netstat at all if there is nothing to do anyway,
and the last adds check for looopback network.

--- pcmcia-cs-3.2.2/cardmgr/ifuser.c	2001-08-24 14:19:20.000000000 +0200
+++ pcmcia-cs-3.2.2-fix/cardmgr/ifuser.c	2003-05-14 10:16:55.000000000 +0200
@@ -108,6 +108,8 @@ int main(int argc, char *argv[])
     }
     if ((*argv[i] == '-') || (argc < i+1)) usage(argv[0]);
     dev = argv[i]; i++;
+    if ( i >= argc )
+	return (!busy);
     
     /* Get routing table */
     f = popen("netstat -nr", "r");
@@ -122,6 +124,8 @@ int main(int argc, char *argv[])
     } while (!feof(f) && !isdigit(s[0]));
     
     tail = &tbl;
+    if ( !isdigit(s[0]) )
+	goto rt_end;
     do {
 	r = malloc(sizeof(route_t));
 	if (r == NULL) {
@@ -134,6 +138,7 @@ int main(int argc, char *argv[])
 	r->match = (strcmp(iface, dev) == 0);
 	*tail = r; tail = &(r->next);
     } while (fgets(s, 128, f) != NULL);
+rt_end:
     *tail = NULL;
     pclose(f);
 
@@ -147,6 +152,8 @@ int main(int argc, char *argv[])
 	}
 
 	for (r = tbl; r; r = r->next) {
+	    if ((a & 0xff000000) == 0x7f000000) /* loopback network */
+		continue;
 	    if ((a & r->mask) == r->dest) {
 		if (r->match) {
 		    if (verbose) {

