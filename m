Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbVISSVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbVISSVT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVISSVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:21:19 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:10716 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932535AbVISSVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:21:18 -0400
Subject: Re: 2.6.14-rc1 wait()/SIG_CHILD bevahiour
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <CEA22AE9-C1D1-4621-B01A-F7D1F6F25110@mac.com>
References: <1127151573.1586.14.camel@dyn9047017102.beaverton.ibm.com>
	 <CEA22AE9-C1D1-4621-B01A-F7D1F6F25110@mac.com>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 11:19:21 -0700
Message-Id: <1127153961.1586.16.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 14:01 -0400, Kyle Moffett wrote:
> On Sep 19, 2005, at 13:39:33, Badari Pulavarty wrote:
> > Hi,
> >
> > I am looking at a problem where the parent process doesn't seem to  
> > cleanup the exited children (with a webserver). We narrowed it down  
> > to a simple testcase. Seems more like a lost SIG_CHILD.
> 
> You don't get one SIG_CHLD per child that quits.  The kernel may and  
> probably will merge SIG_CHLD signals together if it has several  
> queued before it gets a chance to deliver them to your process.  This  
> is true of _all_ signals.  If you "kill -STOP 1234", then "kill -QUIT  
> 1234", "kill -QUIT 1234", "kill -QUIT 1234", "kill -CONT 1234", the  
> PID 1234 will have 3 signals delivered:  The original untrappable  
> SIGSTOP, the SIGCONT that causes it to resume, and a single SIGQUIT  

True.

> immediately following it.  The correct and portable way to handle  
> this is to put a loop in your SIGCHLD signal handler:
> 
> #include <sys/types.h>
> #include <sys/wait.h>
> 
> void sigchld_handler(int signal) {
>      pid_t pid;
>      int status;
> 
>      while( -1 != (child = waitpid(-1, &status, WNOHANG)) ) {
>          /*
>           * Now "status" is the exit status of the child and
>           * "pid" is its pid.  See the waitpid() manpage for
>           * macros you can use to get information from the
>           * status variable.
>           */
>          do_some_processing_of_exited_child(pid,status);
>      }
> }


Thats what I already do, in my current testcase.

    while(1) {
        pid = wait4(-1, &status, WNOHANG, &ru);
        if (pid <= 0) break;
//        printf("SIGCHLD received for pid %d\n", pid);
        pid_exited(pid);
    }


Thanks,
Badari

