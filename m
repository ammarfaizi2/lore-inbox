Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266380AbUGOVw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266380AbUGOVw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 17:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266381AbUGOVw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 17:52:59 -0400
Received: from wingding.demon.nl ([82.161.27.36]:10369 "EHLO wingding.demon.nl")
	by vger.kernel.org with ESMTP id S266380AbUGOVws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 17:52:48 -0400
Date: Thu, 15 Jul 2004 23:52:44 +0200
From: Rutger Nijlunsing <rutger@nospam.com>
To: linux-kernel@vger.kernel.org, Paul Jakma <paul@clubi.ie>
Subject: Re: namespaces (was Re: [Q] don't allow tmpfs to page out)
Message-ID: <20040715215244.GA30119@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <1089878317.40f6392d7e365@imp5-q.free.fr> <20040715080017.GB20889@devserv.devel.redhat.com> <Pine.LNX.4.60.0407151329100.2622@fogarty.jakma.org> <20040715171909.GA5518@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20040715171909.GA5518@pclin040.win.tue.nl>
Organization: M38c
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 15, 2004 at 07:19:09PM +0200, Andries Brouwer wrote:
> On Thu, Jul 15, 2004 at 01:31:08PM +0100, Paul Jakma wrote:
> 
> > speaking of which, how does one use namespaces exactly? The kernel 
> > appears to maintain mount information per process, but how do you set 
> > this up?
> > 
> > neither 'man mount/namespace' nor 'appropos namespace' show up 
> > anything.
> 
> Try "man 2 clone" and look for CLONE_NEWNS.
> 
> Somewhere else I wrote
> 
>   Since 2.4.19/2.5.2, the clone() system call, a generalization of
>   Unix fork() and BSD vfork(), may have the CLONE_NEWNS flag, that
>   says that all mount information must be copied. Afterwards, mount,
>   chroot, pivotroot and similar namespace changing calls done by this
>   new process do influence this process and its children, but not other
>   processes. In particular, the virtual file /proc/mounts that lists the
>   mounted filesystems, is now a symlink to /proc/self/mounts - different
>   processes may live in entirely different file hierarchies.
> 
> Andries

Or your page at

  http://www.win.tue.nl/~aeb/linux/lk/lk-6.html

...which contains a working utility (section 6.3.3).

Attached an adopted version. Call like 'newnamespace /bin/bash' to
start bash in a new namespace.

-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="newnamespace.c"

/* newnamespace.c */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>
#include <sched.h>
#include <sys/types.h>
#include <sys/wait.h>

typedef struct {
  char *path;
  char **argv;
} FuncInfo;

int childfn(void *p) {
  FuncInfo *fi = (FuncInfo *)p;

  /*  setenv("PS1", "@@ ", 1); */
  execv(fi->path, fi->argv);
  perror("execl");
  fprintf(stderr, "Cannot exec '%s'\n", fi->path);
  exit(1);
}

static char *default_path = "/bin/ash";
static char *default_argv[] = {"ash", NULL};

int main(int argc, char *argv[]) {
  char buf[10000];
  pid_t pid, p;
  
  FuncInfo fi;

  if (argc == 1) {
    /* No arguments given */
    fi.path = default_path;
    fi.argv = default_argv;
  } else {
    int i;
    argc--; argv++;
    fi.path = *argv;
    fi.argv = (char **)malloc(sizeof(char *) * (argc + 1));
    for (i = 0; i < argc; i++) {
      fi.argv[i] = argv[i];
    }
    fi.argv[argc] = NULL;
  }

  pid = clone(childfn, buf + 5000, CLONE_NEWNS | SIGCHLD, &fi);
  if ((int) pid == -1) {
    perror("clone");
    exit(1);
  }
  
  p = waitpid(pid, NULL, 0);
  if ((int) p == -1) {
    perror("waitpid");
    exit(1);
  }
  
  exit(0);
}

--M9NhX3UHpAaciwkO--
