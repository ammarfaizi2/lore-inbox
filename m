Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTECWBR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 18:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTECWBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 18:01:16 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:30407 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263447AbTECWAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 18:00:52 -0400
Message-ID: <3EB43EFB.3030302@namesys.com>
Date: Sun, 04 May 2003 02:13:15 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [BK] [2.4] reiserfs: parser fix patch
Content-Type: multipart/mixed;
 boundary="------------040901040904070901060800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040901040904070901060800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Hans


--------------040901040904070901060800
Content-Type: message/rfc822;
 name="[2.4] reiserfs: parser fix patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[2.4] reiserfs: parser fix patch"

Return-Path: <green@angband.namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 24454 invoked from network); 3 May 2003 12:47:03 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 3 May 2003 12:47:03 -0000
Received: by angband.namesys.com (Postfix, from userid 521)
	id B374356AA3C; Sat,  3 May 2003 16:47:03 +0400 (MSD)
Date: Sat, 3 May 2003 16:47:03 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [2.4] reiserfs: parser fix patch
Message-ID: <20030503124703.GC21210@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i

Hello!

    These two changesets fix the problems in reiserfs' option parser.
    Now it will correctly bail out and refuse to mount/remount if
    incorrect options were given. Also it is now aware of exclusive
    options and deals with those correctly, so you can actually
    disable tails after you have enabled those.

    Please pull from bk://namesys.com/bk/reiser3-linux-2.4-parserfix

Diffstat:
 super.c |  122 +++++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 68 insertions(+), 54 deletions(-)

Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1158  -> 1.1160 
#	 fs/reiserfs/super.c	1.31    -> 1.33   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/03	green@angband.namesys.com	1.1159
# Fix reiserfs options parser, return error if given incorrect options on remount
# --------------------------------------------
# 03/05/03	green@angband.namesys.com	1.1160
# reiserfs: Refuse to mount/remount if "alloc=" option had incorect parameter
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Sat May  3 15:56:45 2003
+++ b/fs/reiserfs/super.c	Sat May  3 15:56:45 2003
@@ -403,8 +403,11 @@
    mount options that have values rather than being toggles. */
 typedef struct {
     char * value;
-    int bitmask; /* bit which is to be set in mount_options bitmask when this
-                    value is found, 0 is no bits are to be set */
+    int setmask; /* bitmask which is to set on mount_options bitmask when this
+                    value is found, 0 is no bits are to be changed. */
+    int clrmask; /* bitmask which is to clear on mount_options bitmask when this
+		    value is found, 0 is no bits are to be changed. This is
+		    applied BEFORE setmask */
 } arg_desc_t;
 
 
@@ -414,37 +417,42 @@
     char * option_name;
     int arg_required; /* 0 is argument is not required, not 0 otherwise */
     const arg_desc_t * values; /* list of values accepted by an option */
-    int bitmask;  /* bit which is to be set in mount_options bitmask when this
-		     option is selected, 0 is not bits are to be set */
+    int setmask; /* bitmask which is to set on mount_options bitmask when this
+		    value is found, 0 is no bits are to be changed. */
+    int clrmask; /* bitmask which is to clear on mount_options bitmask when this
+		    value is found, 0 is no bits are to be changed. This is
+		    applied BEFORE setmask */
 } opt_desc_t;
 
 
 /* possible values for "-o hash=" and bits which are to be set in s_mount_opt
    of reiserfs specific part of in-core super block */
 static const arg_desc_t hash[] = {
-    {"rupasov", FORCE_RUPASOV_HASH},
-    {"tea", FORCE_TEA_HASH},
-    {"r5", FORCE_R5_HASH},
-    {"detect", FORCE_HASH_DETECT},
-    {NULL, 0}
+    {"rupasov", 1<<FORCE_RUPASOV_HASH,(1<<FORCE_TEA_HASH)|(1<<FORCE_R5_HASH)},
+    {"tea", 1<<FORCE_TEA_HASH,(1<<FORCE_RUPASOV_HASH)|(1<<FORCE_R5_HASH)},
+    {"r5", 1<<FORCE_R5_HASH,(1<<FORCE_RUPASOV_HASH)|(1<<FORCE_TEA_HASH)},
+    {"detect", 1<<FORCE_HASH_DETECT, (1<<FORCE_RUPASOV_HASH)|(1<<FORCE_TEA_HASH)|(1<<FORCE_R5_HASH)},
+    {NULL, 0, 0}
 };
 
 
 /* possible values for "-o block-allocator=" and bits which are to be set in
    s_mount_opt of reiserfs specific part of in-core super block */
 static const arg_desc_t balloc[] = {
-    {"noborder", REISERFS_NO_BORDER},
-    {"no_unhashed_relocation", REISERFS_NO_UNHASHED_RELOCATION},
-    {"hashed_relocation", REISERFS_HASHED_RELOCATION},
-    {"test4", REISERFS_TEST4},
-    {NULL, 0}
+    {"noborder", 1<<REISERFS_NO_BORDER, 0},
+    {"border", 0, 1<<REISERFS_NO_BORDER},
+    {"no_unhashed_relocation", 1<<REISERFS_NO_UNHASHED_RELOCATION, 0},
+    {"hashed_relocation", 1<<REISERFS_HASHED_RELOCATION, 0},
+    {"test4", 1<<REISERFS_TEST4, 0},
+    {"notest4", 0, 1<<REISERFS_TEST4},
+    {NULL, 0, 0}
 };
 
 static const arg_desc_t tails[] = {
-    {"on", REISERFS_LARGETAIL},
-    {"off", -1},
-    {"small", REISERFS_SMALLTAIL},
-    {NULL, 0}
+    {"on", 1<<REISERFS_LARGETAIL, 1<<REISERFS_SMALLTAIL},
+    {"off", 0, (1<<REISERFS_LARGETAIL)|(1<<REISERFS_SMALLTAIL)},
+    {"small", 1<<REISERFS_SMALLTAIL, 1<<REISERFS_LARGETAIL},
+    {NULL, 0, 0}
 };
 
 
@@ -481,15 +489,20 @@
 	/* Ugly special case, probably we should redo options parser so that
 	   it can understand several arguments for some options, also so that
 	   it can fill several bitfields with option values. */
-	reiserfs_parse_alloc_options( s, p + 6);
-	return 0;
+	if ( reiserfs_parse_alloc_options( s, p + 6) ) {
+	    return -1;
+	} else {
+	    return 0;
+	}
     }
 	
     /* for every option in the list */
     for (opt = opts; opt->option_name; opt ++) {
 	if (!strncmp (p, opt->option_name, strlen (opt->option_name))) {
-	    if (bit_flags && opt->bitmask != -1 )
-		set_bit (opt->bitmask, bit_flags);
+	    if (bit_flags) {
+		*bit_flags &= ~opt->clrmask;
+		*bit_flags |= opt->setmask;
+	    }
 	    break;
 	}
     }
@@ -529,7 +542,7 @@
     }
     
     if (!opt->values) {
-	/* *opt_arg contains pointer to argument */
+	/* *=NULLopt_arg contains pointer to argument */
 	*opt_arg = p;
 	return opt->arg_required;
     }
@@ -537,8 +550,10 @@
     /* values possible for this option are listed in opt->values */
     for (arg = opt->values; arg->value; arg ++) {
 	if (!strcmp (p, arg->value)) {
-	    if (bit_flags && arg->bitmask != -1 )
-		set_bit (arg->bitmask, bit_flags);
+	    if (bit_flags) {
+		*bit_flags &= ~arg->clrmask;
+		*bit_flags |= arg->setmask;
+	    }
 	    return opt->arg_required;
 	}
     }
@@ -547,7 +562,6 @@
     return -1;
 }
 
-
 /* returns 0 if something is wrong in option string, 1 - otherwise */
 static int reiserfs_parse_options (struct super_block * s, char * options, /* string given via mount's -o */
 				   unsigned long * mount_options,
@@ -560,18 +574,21 @@
     char * arg = NULL;
     char * pos;
     opt_desc_t opts[] = {
-		{"tails", 't', tails, -1},
-		{"notail", 0, 0, -1}, /* Compatibility stuff, so that -o notail for old setups still work */
-		{"conv", 0, 0, REISERFS_CONVERT}, 
-		{"nolog", 0, 0, -1},
-		{"replayonly", 0, 0, REPLAYONLY},
+		{"tails", 't', tails, 0, 0},
+		/* Compatibility stuff, so that -o notail
+		   for old setups still work */
+		{"notail", 0, 0, 0, (1<<REISERFS_LARGETAIL)|(1<<REISERFS_SMALLTAIL)},
+		{"conv", 0, 0, 1<<REISERFS_CONVERT, 0},
+		{"nolog", 0, 0, 0, 0}, /* This is unsupported */
+		{"replayonly", 0, 0, 1<<REPLAYONLY, 0},
 		
-		{"block-allocator", 'a', balloc, -1}, 
-		{"hash", 'h', hash, FORCE_HASH_DETECT},
+		{"block-allocator", 'a', balloc, 0, 0},
+		{"hash", 'h', hash, 1<<FORCE_HASH_DETECT, 0},
 		
-		{"resize", 'r', 0, -1},
-		{"attrs", 0, 0, REISERFS_ATTRS},
-		{NULL, 0, 0, 0}
+		{"resize", 'r', 0, 0, 0},
+		{"attrs", 0, 0, 1<<REISERFS_ATTRS, 0},
+		{"noattrs", 0, 0, 0, 1<<REISERFS_ATTRS},
+		{NULL, 0, 0, 0, 0}
     };
 	
     *blocks = 0;
@@ -579,9 +596,6 @@
 	/* use default configuration: create tails, journaling on, no
 	   conversion to newest format */
 	return 1;
-    else
-	/* Drop defaults to zeroes */
-	*mount_options = 0;
     
     for (pos = options; pos; ) {
 	c = reiserfs_getopt (s, &pos, opts, &arg, mount_options);
@@ -635,26 +649,26 @@
   struct reiserfs_super_block * rs;
   struct reiserfs_transaction_handle th ;
   unsigned long blocks;
-  unsigned long mount_options = 0;
+  unsigned long mount_options = s->u.reiserfs_sb.s_mount_opt;
+  unsigned long safe_mask = 0;
 
   rs = SB_DISK_SUPER_BLOCK (s);
 
   if (!reiserfs_parse_options(s, data, &mount_options, &blocks))
-  	return 0;
+  	return -EINVAL;
 
-#define SET_OPT( opt, bits, super )					\
-    if( ( bits ) & ( 1 << ( opt ) ) )					\
-	    ( super ) -> u.reiserfs_sb.s_mount_opt |= ( 1 << ( opt ) )
-
-  /* set options in the super-block bitmask */
-  SET_OPT( REISERFS_SMALLTAIL, mount_options, s );
-  SET_OPT( REISERFS_LARGETAIL, mount_options, s );
-  SET_OPT( REISERFS_NO_BORDER, mount_options, s );
-  SET_OPT( REISERFS_NO_UNHASHED_RELOCATION, mount_options, s );
-  SET_OPT( REISERFS_HASHED_RELOCATION, mount_options, s );
-  SET_OPT( REISERFS_TEST4, mount_options, s );
-  SET_OPT( REISERFS_ATTRS, mount_options, s );
-#undef SET_OPT
+  /* Add options that are safe here */
+  safe_mask |= 1 << REISERFS_SMALLTAIL;
+  safe_mask |= 1 << REISERFS_LARGETAIL;
+  safe_mask |= 1 << REISERFS_NO_BORDER;
+  safe_mask |= 1 << REISERFS_NO_UNHASHED_RELOCATION;
+  safe_mask |= 1 << REISERFS_HASHED_RELOCATION;
+  safe_mask |= 1 << REISERFS_TEST4;
+  safe_mask |= 1 << REISERFS_ATTRS;
+
+  /* Update the bitmask, taking care to keep
+   * the bits we're not allowed to change here */
+  s->u.reiserfs_sb.s_mount_opt = (s->u.reiserfs_sb.s_mount_opt & ~safe_mask) | (mount_options & safe_mask);
 
   handle_attrs( s );
 



--------------040901040904070901060800--

