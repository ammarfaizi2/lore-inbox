Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130411AbRCEUTN>; Mon, 5 Mar 2001 15:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130412AbRCEUTE>; Mon, 5 Mar 2001 15:19:04 -0500
Received: from node1600a.a2000.nl ([24.132.96.10]:13999 "EHLO
	appel.lilypond.org") by vger.kernel.org with ESMTP
	id <S130411AbRCEUSs>; Mon, 5 Mar 2001 15:18:48 -0500
To: root@chaos.analogic.com
Cc: Pavel Machek <pavel@suse.cz>, Erik Hensema <erik@hensema.xs4all.nl>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: [PATCH #3]: print missing interpreter name [Was: Re: binfmt_script and ^M]
In-Reply-To: <Pine.LNX.3.95.1010305105132.9913B-100000@chaos.analogic.com>
Organization: Jan at Appel
From: Jan Nieuwenhuizen <janneke@gnu.org>
Date: 05 Mar 2001 21:18:35 +0100
In-Reply-To: "Richard B. Johnson"'s message of "Mon, 5 Mar 2001 10:59:48 -0500 (EST)"
Message-ID: <m3y9ukezqc.fsf@appel.lilypond.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> No. I did not miss the point. The 'No such file or directory' error
> (when you can see the ^$^$)#@@*& filename with 'ls'), usually means
> that there is something wrong with the file.

Now, let's see.  When this error happens, it can be one of these:

    1a) the script itself is broken (eg, it has `#!/bin/bash\r')
    1b) the interpreter is missing, (eg, the script has
        `#!/usr/bin/perl', while perl got removed during the
        grand perl repackaging)
    2)  the interpreter is broken, (eg, missing shared library)
    3)  the script does not exist

In any case, the heart of the problems 1) and 2) is expressed by the
fact that there's something fishy with #!INTERPRETER.  In the case of
1a, the script should be fixed, in case 1b, the system should be
fixed, but this doesn't really matter.  Either way: INTERPRETER is the
file the kernel is talking about when it says ENOENT.  Only in case 3),
the ENOENT is about the script itself.

It seems reasonable, and helpful, for bash to print the name of the
INTERPRETER.

> Usually, I have found that it was an executable linked against some
> other runtime library than what I have. `strace` finds this quickly.

Well, this doesn't mean very much, other than you happen to experience
2) most (and you're fast at identifying the strange error).  But even
in this case, the name of the broken interpreter is what you should be
warned about.  Maybe others usually experience 1b), who cares?

In this third incarnation of my patch (today really isn't my day), you
see these messages for 1-3:

1)
    $ cat /bin/foo.sh 
    #!/foo/bar/baz
    echo bar

    $ /bin/bash -c /bin/foo.sh 
    /bin/bash: /bin/foo.sh: No such file or directory

    $ ./new/bash -c /bin/foo.sh 
    ./new/bash: /bin/foo.sh: /foo/bar/baz: No such file or directory

2)
    $ cat /bin/no-ld.sh 
    #!/usr/bin/urg
    $ ldd /bin/urg                
	    libkpathsea.so.3 => not found
            [..]

    $ /bin/bash -c /bin/no-ld.sh 
    /bin/bash: /bin/no-ld.sh: No such file or directory

    $ ./new/bash -c /bin/no-ld.sh 
    ./new/bash: /bin/no-ld.sh: /usr/bin/urg: No such file or directory

3)
    $ /bin/bash -c /bin/no-such-foo.sh
    /bin/bash: /bin/no-such-foo.sh: No such file or directory

    $ ./new/bash -c /bin/no-such-foo.sh
    ./new/bash: /bin/no-such-foo.sh: No such file or directory


Ok, here goes try #3:

--- ../bash-2.04.orig/ChangeLog	Mon Mar  5 21:06:11 2001
+++ ./ChangeLog	Mon Mar  5 19:22:46 2001
@@ -0,0 +1,5 @@
+2001-03-05  Jan Nieuwenhuizen  <janneke@gnu.org>
+
+	* execute_cmd.c (extract_hash_bang_interpreter): New function.
+	(shell_execve): More informative error message.
+
--- ../bash-2.04.orig/execute_cmd.c	Tue Jan 25 17:29:11 2000
+++ ./execute_cmd.c	Mon Mar  5 20:35:46 2001
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
 
@@ -3326,7 +3362,17 @@
       else
 	{
 	  errno = i;
-	  file_error (command);
+	  if (errno == ENOENT)
+	    {
+	      char buf[80];
+	      char *interpreter = extract_hash_bang_interpreter (command, buf);
+	      if (strlen (interpreter))
+		sys_error ("%s: %s", command, interpreter);
+	      else
+		file_error (command);
+	    }
+	  else
+	    file_error (command);
 	}
       return ((i == ENOENT) ? EX_NOTFOUND : EX_NOEXEC);	/* XXX Posix.2 says that exit status is 126 */
     }


-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org

