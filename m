Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263566AbTD1MrD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 08:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTD1MrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 08:47:02 -0400
Received: from chaos.analogic.com ([204.178.40.224]:23181 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263566AbTD1Mq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 08:46:56 -0400
Date: Mon, 28 Apr 2003 09:00:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Mark Grosberg <mark@nolab.conman.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <Pine.BSO.4.44.0304272207431.23296-100000@kwalitee.nolab.conman.org>
Message-ID: <Pine.LNX.4.53.0304280855240.16444@chaos>
References: <Pine.BSO.4.44.0304272207431.23296-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Apr 2003, Mark Grosberg wrote:

>
>
> On Sun, 27 Apr 2003, Richard B. Johnson wrote:
>
> > You don't save anything but one system call time which is inconsequential
> > compared to the time necessary to exec (load a file, etc). Also, it is
> > worthless for anything except the most basic 'system()' or popen()
>
> Actually, my original proposal will work for popen and all sorts of piping
> because of the file descriptor map. For example:
>
>    int   in[2], out[2];
>    char *null_argv[] = { NULL };
>    int   fmap[4];
>    pid_t p;
>
>    pipe(in);
>    pipe(out);
>
>    fmap[0] = in[0];                     /* STDIN  */
>    fmap[1] = out[1];                    /* STDOUT */
>    fmap[2] = open("/dev/null", O_RDWR); /* STDERR */
>    fmap[3] = -1;                        /* end    */
>
>    p = nexec("/bin/cat",
>              null_argv,
>              NULL,
>              filmap);
>
>
> In this case you save the extra closes the child would have to do and you
> save the dup's.
>
> > All it does is add kernel bloat and duplicate existing kernel code
> > (both). Learn Unix instead of trying to make it VMS with spawn().
>
> Ahem, I happen to know Unix very well, thank you very much. Please read my
> proposed API before flaming it out and assuming I know nothing of UNIX,
> kernel development, or operating systems in general!
>
> Do you honestly think that just because I picked a name spawn() that
> happens to be in VMS (and MS-DOS C compilers) that I am inexperienced to
> Unix. Nope. I just happen to be a BSD user in general and don't frequent
> LKML.... and now I remember WHY!
>
> And there _ARE_ issues this does solve as were already pointed out because
> of the linear scan that must be made on the file descriptor array for the
> close-on-exec flag (which this API could happily say it ignores since it
> builds a _WHOLE_NEW file descriptor array).
>
> L8r,
> Mark G.


The Unix API provides execve(), fexecve(), execv(), execle(),
execl(), execvp(), and execlp() for what you call 'exec'. So
there is no 'fork and exec' as you state.

The kernel provides one system call, execve(). All of the
other functional changes are done with 'C' wrappers in the
'C' runtime library. To make a generic fork-exec, would require
that this code, or its functionality, be moved into the kernel.

To save some processing time, most knowledgeable software
engineers would use vfork(). This leaves the major time,
the time necessary to load the new application into the
new address space and begin its execution. This time could
be tens of milliseconds or even hundreds if the application
is on a CD, floppy, a disk that hasn't been accessed yet,
or the network. In the usuall situation where processing
must be performed between the fork() and the execve(), you
can't use vfork().

You can measure the time for a system call by executing
getpid() or something similar. It is in the noise compared
to the time necessary to execute a program. Further, we
get to the situation where one can't even verify a supposed
speed increase because the system call overhead is in the
noise. Great, one can claim any improvement they want and
it can't be verified. What will be verified, though, is
the increase in size of the kernel.

The following is a "simple popem()', about as minimal as
you can get and have it work.


 *   invocation as `/bin/sh -c COMMAND`. 0 reads 1 writes.
 */
FILE *popen(const char *command, const char *type)
{
    size_t i;
    int fd2close;
    struct sigaction sa;
    char *args[NR_ARGS];
    FILE *file;
    if((command == NULL) || (type == NULL))
    {
        errno = EINVAL;
        return NULL;
    }
    if(!((*type == (char)'r') || (*type == (char)'w')))
    {
        errno = EINVAL;
        return NULL;
    }
    if((file = (FILE *) malloc(sizeof(FILE))) == NULL)
    {
        return file;
    }
    bzero(file, sizeof(FILE));
    if(pipe(file->pfd))
    {
        free(file);
        return NULL;
    }
    fd2close = 0xff;
    if(*type == (char)'r')
    {
        file->fd = file->pfd[0];
        fd2close = file->pfd[1];
    }
    else
    {
        file->fd = file->pfd[1];
        fd2close = file->pfd[0];
    }
    i = 0;
    args[i++] = "/bin/sh";
    args[i++] = "-c";
    args[i++] = strtok((char *)command, " ");
    for(; i< NR_ARGS; i++)
        if((args[i] = strtok(NULL, " ")) == NULL)
            break;
    for(i++; i < NR_ARGS; i++)
        args[i] = NULL;
    sigaction(SIGCHLD, NULL, &sa);     /* Save old */
    signal(SIGCHLD, SIG_IGN);
    switch((file->pid=fork()))
    {
    case 0:
        if(*type == (char)'r')
        {
            dup2(file->pfd[1], STDOUT_FILENO);
            (void)close(file->pfd[0]);
        }
        else
        {
            dup2(file->pfd[0], STDIN_FILENO);
            (void)close(file->pfd[1]);
        }
        signal(SIGINT, SIG_IGN);
        signal(SIGQUIT, SIG_IGN);
        execve(args[0], args, __environ);
        exit(EXIT_FAILURE);
        break;
    case -1:
        (void)close(file->pfd[0]);
        (void)close(file->pfd[1]);
        free(file);
        return NULL;
    default:
        break;
    }
    file->magic = POPEN;
    sigaction(SIGCHLD, &sa, NULL);     /* Restore old */
    (void)close(fd2close);
    return file;
}

Clearly, some additional, non-generic, processing has to
occur after the fork() and before execve(). For instance,
in the parent it is mandatory that the file descriptor that
is not being accessed by the parent be closed just as it
is mandatory that the file descriptor that is not being
accessed by the child be closed. Otherwise, a read from
the file descriptor by the parent, will not error-out
and return control to the parent when the child closes its
end of the pipe. All these 'trivial little details' are
necessary to have individual function calls work as a
system. That's why Unix breaks these functions into little
pieces (primitives) so the writer has control over the
overall behavior of the complete system. Integration of
these components into a monolythic conglomeration has
always failed to provide increased functionality or
performance, instead it simply reduces the number of
lines of code necessary to be written and maintained.

Reducing the number of lines of code may be a good thing.
However, the proper place for that is in the 'C' library,
not the kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

