Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbRCENUz>; Mon, 5 Mar 2001 08:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129250AbRCENUo>; Mon, 5 Mar 2001 08:20:44 -0500
Received: from node1600a.a2000.nl ([24.132.96.10]:39593 "EHLO
	appel.lilypond.org") by vger.kernel.org with ESMTP
	id <S129259AbRCENUb>; Mon, 5 Mar 2001 08:20:31 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: Erik Hensema <erik@hensema.xs4all.nl>, linux-kernel@vger.kernel.org,
        bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010227140333.C20415@cistron.nl>
	<E14XkQG-0003R7-00@the-village.bc.nu>
	<20010228211043.A4579@hensema.xs4all.nl> <20010301120446.A34@(none)>
Organization: Jan at Appel
From: Jan Nieuwenhuizen <janneke@gnu.org>
Date: 05 Mar 2001 14:20:23 +0100
In-Reply-To: Pavel Machek's message of "Thu, 1 Mar 2001 12:04:47 +0000"
Message-ID: <m3k8648i94.fsf@appel.lilypond.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> > $ head -1 testscript
> > #!/bin/sh
> > $ ./testscript
> > bash: ./testscript: No such file or directory
> 
> What kernel wants to say is "/usr/bin/perl\r: no such file". Saying ENOEXEC
> would be even more confusing.

So, why don't we make bash say that, then?  As I guess that we've all
been bitten by this before.

What are the chances for something like this to be included?

Greetings,
Jan.


--- ../bash-2.04/execute_cmd.c	Tue Jan 25 17:29:11 2000
+++ ./execute_cmd.c	Mon Mar  5 13:50:23 2001
@@ -3035,6 +3035,42 @@
     }
 }
 
+/* Look for #!INTERPRETER in file COMMAND, and return INTERPRETER . */
+static char *
+extract_hash_bang_interpreter (char *command, char buf[80])
+{
+  int fd;
+  char *interpreter;
+
+  interpreter = "";
+  fd = open (command, O_RDONLY);
+  if (fd >= 0)
+    {
+      int len;
+	      
+      len = read (fd, (char *)buf, 80);
+      close (fd);
+	      
+      if (len > 0
+	  && buf[0] == '#' && buf[1] == '!')
+	{
+	  int i;
+	  int start;
+		  
+	  for (i = 2; whitespace (buf[i]) && i < len; i++)
+	    ;
+	  
+	  for (start = i;
+	       !whitespace (buf[i]) && buf[i] != '\n' && i < len;
+	       i++)
+	    ;
+
+	  interpreter = substring ((char *)buf, start, i);
+	}
+    }
+  return interpreter;
+}
+
 /* Execute a simple command that is hopefully defined in a disk file
    somewhere.
 
@@ -3155,7 +3191,12 @@
 
       if (command == 0)
 	{
-	  internal_error ("%s: command not found", pathname);
+	  char buf[80];
+	  char *interpreter = extract_hash_bang_interpreter (pathname, buf);
+	      
+	  internal_error ("%s: command not found: `%s'", pathname,
+			  interpreter);
+	  
 	  exit (EX_NOTFOUND);	/* Posix.2 says the exit status is 127 */
 	}
 


-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org

