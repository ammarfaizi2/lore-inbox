Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbTBSPCP>; Wed, 19 Feb 2003 10:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268927AbTBSPCP>; Wed, 19 Feb 2003 10:02:15 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47626 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268926AbTBSPCF>; Wed, 19 Feb 2003 10:02:05 -0500
Date: Wed, 19 Feb 2003 16:11:43 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, andrea@suse.de
Subject: accessing bitkeeper without bitkeeper
Message-ID: <20030219151143.GA7877@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

With attached patch to CSSC (www.sf.net/projects/cssc), and 

rsync -zav --delete nl.linux.org::kernel/linux-2.5 linux-2.5

you can download local copy of whole linux-2.5 repository, and you can
access it, too.

								Pavel

Index: CSSC/sccsfile.cc
===================================================================
RCS file: /cvsroot/cssc/gnu/CSSC/sccsfile.cc,v
retrieving revision 1.50
diff -u -u -r1.50 sccsfile.cc
--- CSSC/sccsfile.cc	7 Apr 2002 02:22:35 -0000	1.50
+++ CSSC/sccsfile.cc	19 Feb 2003 15:07:24 -0000
@@ -122,17 +122,20 @@
       return NULL;
     }
   
-  if (getc(f_local) != '\001' || getc(f_local) != 'h')
+  int c;
+  if (getc(f_local) != '\001' || (c = getc(f_local)) != 'h')
     {
-      (void)fclose(f_local);
-      s_corrupt_quit("%s: No SCCS-file magic number.  "
-		     "Did you specify the right file?", name);
-      /*NOTEACHED*/
-      return NULL;
+      if (c=='H')
+	warning("This is BitKeeper file\n");
+      else {
+	(void)fclose(f_local);
+	s_corrupt_quit("%s: No SCCS-file magic number.  "
+		       "Did you specify the right file?", name);
+	/*NOTEACHED*/
+	return NULL;
+      }
     }
-  
-  
-  int c;
+
   errno = 0;
   while ( (c=getc(f_local)) != CONFIG_EOL_CHARACTER)
     {
@@ -462,7 +465,7 @@
 		/* check_arg(); */
 		if (bufchar(2) != ' ')
 		  {
-		    saw_unknown_feature("Unknown special comment intro %c%c",
+		    saw_unknown_feature("Unknown special comment intro %c%c\n",
 					c, bufchar(2));
 		  }
 		tmp.comments.add(plinebuf->c_str() + 3);
@@ -581,12 +584,13 @@
     }
   
   int c = read_line();
-  ASSERT(c == 'h');
+  ASSERT((c == 'h') || (c == 'H'));
 
   /* the checksum is represented in the file as decimal.
    */
   signed int given_sum = 0;
-  if (1 != sscanf(plinebuf->c_str(), "%*ch%d", &given_sum))
+  if ((1 != sscanf(plinebuf->c_str(), "%*ch%d", &given_sum)) &&
+      (1 != sscanf(plinebuf->c_str(), "%*cH%d", &given_sum)))
     {
       errormsg("Expected checksum line, found line beginning '%.3s'\n",
 	       plinebuf->c_str());
@@ -755,8 +759,12 @@
 	else
 	  corrupt("Bad value for 'e' flag.");
 	break;
+      case 'x':
+	warning("Unknown flag x, BitKeeper?.");
+	break;
 	
       default:
+	warning("Unknown flag (%c).", bufchar(3));
 	corrupt("Unknown flag.");
       }
       

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
