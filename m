Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUJNSe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUJNSe5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUJNSe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:34:27 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:63698 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266901AbUJNSAI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:00:08 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 14 Oct 2004 19:49:53 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Roland McGrath <roland@redhat.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: ptrace bug in -rc2+
Message-ID: <20041014174952.GA29335@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

The introduction of the new TASK_TRACED state in 2.6.9-rc2 changed the
behavior of the kernel in a IMHO buggy way.  Sending a SIGKILL to a
process which is traced _and_ stopped doesn't work any more.  user mode
linux kernels do that on shutdown, thats why I ran into this.

Below is a short test app which shows the behavior.  On 2.6.9-rc2+ the
last waitpid() call blocks forever, on older kernels it doesn't ...

  Gerd

==============================[ cut here ]==============================
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc, char *argv[])
{
	int child,rc,status;

	child = fork();
	if (0 == child) {
		fprintf(stderr,"[child] ptrace me ...\n");
		ptrace(PTRACE_TRACEME);
		fprintf(stderr,"[child] exec sleep 10 ...\n");
		execlp("sleep", "sleep", "10", NULL);
		perror("execlp");
		exit(1);
	}

	sleep(1);
	fprintf(stderr,"kill %d,STOP ...\n",child);
	kill(child,SIGSTOP);
	fprintf(stderr,"waitpid %d...\n",child);
	rc = waitpid(child,&status,WUNTRACED);
	fprintf(stderr,"%s: rc=%d status=%s%s%s termsig=%d\n",__FUNCTION__,rc,
		WIFEXITED(status)   ? "exit"    : "",
		WIFSIGNALED(status) ? "signal"  : "",
		WIFSTOPPED(status)  ? "stopped" : "",
		WTERMSIG(status));

	sleep(1);
	fprintf(stderr,"kill %d,KILL ...\n",child);
	kill(child,SIGKILL);
	fprintf(stderr,"waitpid %d...\n",child);
	rc = waitpid(child,&status,WUNTRACED);
	fprintf(stderr,"%s: rc=%d status=%s%s%s termsig=%d\n",__FUNCTION__,rc,
		WIFEXITED(status)   ? "exit"    : "",
		WIFSIGNALED(status) ? "signal"  : "",
		WIFSTOPPED(status)  ? "stopped" : "",
		WTERMSIG(status));

	exit(0);
}
