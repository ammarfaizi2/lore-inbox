Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbRCEO5Q>; Mon, 5 Mar 2001 09:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129323AbRCEO5G>; Mon, 5 Mar 2001 09:57:06 -0500
Received: from node1600a.a2000.nl ([24.132.96.10]:62890 "EHLO
	appel.lilypond.org") by vger.kernel.org with ESMTP
	id <S129321AbRCEO46>; Mon, 5 Mar 2001 09:56:58 -0500
To: root@chaos.analogic.com
Cc: Pavel Machek <pavel@suse.cz>, Erik Hensema <erik@hensema.xs4all.nl>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: [PATCH]: print missing interpreter name [Was: Re: binfmt_script and ^M]
In-Reply-To: <Pine.LNX.3.95.1010305083112.8719A-100000@chaos.analogic.com>
Organization: Jan at Appel
From: Jan Nieuwenhuizen <janneke@gnu.org>
Date: 05 Mar 2001 15:56:54 +0100
In-Reply-To: "Richard B. Johnson"'s message of "Mon, 5 Mar 2001 08:40:22 -0500 (EST)"
Message-ID: <m3vgpo462x.fsf@appel.lilypond.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> So why would you even consider breaking bash as a work-around for
> a broken script?

I don't.

> Somebody must have missed the boat entirely. Unix does not, never
> has, and never will end a text line with '\r'. It's Microsoft junk
> that does that, a throwback to CP/M, a throwback to MDS/200.

Yes, we all know that, but you missed the point.  As far as this patch
goes, it's got nothing to do with the '\r'.  It's meant to get a more
informative error message from bash, if ``#!INTERPRETER'' does not
exist.  Look:

    $ cat /bin/foo.sh
    #!/foo/bar/baz
    echo bar
    $ /bin/bash -c /bin/foo.sh 
    /bin/bash: /bin/foo.sh: No such file or directory
    $ ./build/bash -c /bin/foo.sh 
    ./build/bash: /foo/bar: No such file or directory

Maybe the message could even be better, but having `/foo/bar' printed,
ie, the file that the kernel says does not exist, iso `/bin/foo.sh',
the name of the script, that certainly does exist, may help.  Possibly
both should be printed.

Greetings,
Jan.

I made a silly mistake in previous patch, sorry.

--- ../bash-2.04.orig/ChangeLog	Mon Mar  5 13:58:48 2001
+++ ./ChangeLog	Mon Mar  5 15:28:19 2001
@@ -0,0 +1,5 @@
+2001-03-05  Jan Nieuwenhuizen  <jan@netland.nl>
+
+	* execute_cmd.c (extract_hash_bang_interpreter): New function.
+	(shell_execve): More informative error message.
+
--- ../bash-2.04.orig/execute_cmd.c	Tue Jan 25 17:29:11 2000
+++ ./execute_cmd.c	Mon Mar  5 15:29:37 2001
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
 
@@ -3326,6 +3362,11 @@
       else
 	{
 	  errno = i;
+	  if (errno == ENOENT)
+	    {
+	      char buf[80];
+	      command = extract_hash_bang_interpreter (command, buf);
+	    }
 	  file_error (command);
 	}
       return ((i == ENOENT) ? EX_NOTFOUND : EX_NOEXEC);	/* XXX Posix.2 says that exit status is 126 */

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org

