Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318297AbSG3Oc4>; Tue, 30 Jul 2002 10:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318298AbSG3Oc4>; Tue, 30 Jul 2002 10:32:56 -0400
Received: from mx0.gmx.de ([213.165.64.100]:14856 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S318297AbSG3Oci>;
	Tue, 30 Jul 2002 10:32:38 -0400
Date: Tue, 30 Jul 2002 16:35:55 +0200 (MEST)
From: Michael Kerrisk <m.kerrisk@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Weirdness with AF_INET listen() backlog [2.4.18]
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0005657596@gmx.net
X-Authenticated-IP: [213.7.9.210]
Message-ID: <7911.1028039755@www55.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

First of all, apologies for the length of this message, but hopefully it
contains all the information necessary to show the problem I'm seeing.

I'm seeing some puzzling behaviour with the backlog argument to listen()
with AF_INET sockets on Linux 2.4.18 (SuSE 8.0).

I had expected that if a server creates a listening socket, but does not
accept() the incoming connections, then after the (possibly fudge-factored)
connection limit specified by backlog was reached, further client connect()s
would block and eventually fail with the error ETIMEDOUT.  (This is the behaviour
on other Unices that I'm familiar with.)

I wrote a test program (below) to try and understand what's happening on
Linux.  The program creates a listening socket, and then loops calling connect()
to create pending connections to the listening socket.  (Accept() is never
called.)

What I observed is that upon reaching the backlog value, further connect()s
would each block for a few seconds, and then succeed.  

Using netstat, I could see that the active socket went into the ESTABLISHED
state, while its peer sat in the SYN_RECV state.  Eventually (after about 3
mins), the sockets in the SYN_RECV state disappear from netstat's view.  (See
OUTPUT LOG 1 below)

I added an option to my test program to use getsockopt(... SO_ERROR ...) to
check for pending errors on all of the active sockets after each connect(). 
No errors were returned.

I then added a further option to the program so that after each connect() it
did a write() of a single byte to each socket.  In this case, SO_ERROR does
eventually return ECONNRESET and write() fails with EPIPE.  (See OUTPUT LOG 2
below)

Is this all expected behaviour?  If so, is there a way of getting Linux to
behave more like other implementations here?  (As a wild shot I tried setting
/proc/sys/net/ipv4/tcp_syncookies to 0, but this made no apparent
difference.)

Cheers

Michael

=========================
OUTPUT LOG 1
    $ max_backlog -b 5 -i &
    Using a backlog of 5
    1: connect of fd 4 returned 0 at 15:35:44
            Port is 35092
    2: connect of fd 5 returned 0 at 15:35:44
            Port is 35093
    3: connect of fd 6 returned 0 at 15:35:44
            Port is 35094
    4: connect of fd 7 returned 0 at 15:35:44
            Port is 35095
    5: connect of fd 8 returned 0 at 15:35:44
            Port is 35096
    6: connect of fd 9 returned 0 at 15:35:44
            Port is 35097
    7: connect of fd 10 returned 0 at 15:35:44
            Port is 35098
    8: connect of fd 11 returned 0 at 15:35:44
            Port is 35099
    [1] 15227
    $ netstat | egrep '(50001|For)' | sort +3
    Proto Recv-Q Send-Q Local Address      Foreign Address    State
    tcp        0      0 localhost:35092    localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35093    localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35094    localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35095    localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35096    localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35097    localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35098    localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35099    localhost:50001    ESTABLISHED
    tcp        0      1 localhost:35100    localhost:50001    SYN_SENT
    tcp        0      0 localhost:50001    localhost:35092    ESTABLISHED
    tcp        0      0 localhost:50001    localhost:35093    ESTABLISHED
    tcp        0      0 localhost:50001    localhost:35094    ESTABLISHED
    tcp        0      0 localhost:50001    localhost:35095    ESTABLISHED
    tcp        0      0 localhost:50001    localhost:35096    ESTABLISHED
    tcp        0      0 localhost:50001    localhost:35097    ESTABLISHED
    tcp        0      0 localhost:50001    localhost:35098    SYN_RECV
    tcp        0      0 localhost:50001    localhost:35099    SYN_RECV
    
<<Note: the following connect blocked for 9 seconds...  Each subsequent 
connect blocks for a few seconds...>>
    $ 9: connect of fd 12 returned 0 at 15:35:53
            Port is 35100
    10: connect of fd 13 returned 0 at 15:35:53
            Port is 35101
<<snip>>
    18: connect of fd 21 returned 0 at 15:36:20
            Port is 35109
    19: connect of fd 22 returned 0 at 15:36:23
            Port is 35110
    netstat | egrep '(50001|For)' | sort +3 | grep RECV
    Proto Recv-Q Send-Q Local Address      Foreign Address    State
    tcp        0      0 localhost:50001    localhost:35098    SYN_RECV
    tcp        0      0 localhost:50001    localhost:35099    SYN_RECV
    tcp        0      0 localhost:50001    localhost:35100    SYN_RECV
    tcp        0      0 localhost:50001    localhost:35101    SYN_RECV
    tcp        0      0 localhost:50001    localhost:35102    SYN_RECV
    tcp        0      0 localhost:50001    localhost:35103    SYN_RECV
<<snip>>
    tcp        0      0 localhost:50001    localhost:35110    SYN_RECV
    $ 20: connect of fd 23 returned 0 at 15:36:26
            Port is 35111
    21: connect of fd 24 returned 0 at 15:36:26
            Port is 35112
    22: connect of fd 25 returned 0 at 15:36:29
            Port is 35113
<<snip>>
    51: connect of fd 54 returned 0 at 15:37:56
            Port is 35142
    netstat | egrep '(50001|For)' | sort +3 | grep RECV
    Proto Recv-Q Send-Q Local Address      Foreign Address    State
    tcp        0      0 localhost:50001    localhost:35098    SYN_RECV
    tcp        0      0 localhost:50001    localhost:35099    SYN_RECV
    tcp        0      0 localhost:50001    localhost:35100    SYN_RECV
    tcp        0      0 localhost:50001    localhost:35101    SYN_RECV
    tcp        0      0 localhost:50001    localhost:35102    SYN_RECV
<<snip>>
    tcp        0      0 localhost:50001    localhost:35142    SYN_RECV
    $ 52: connect of fd 55 returned 0 at 15:38:05
            Port is 35143
    53: connect of fd 56 returned 0 at 15:38:05
            Port is 35144
    54: connect of fd 57 returned 0 at 15:38:14
            Port is 35145
<<snip>>
    67: connect of fd 70 returned 0 at 15:39:08
            Port is 35158
    netstat | egrep '(50001|For)' | sort +3 | grep RECV
    Proto Recv-Q Send-Q Local Address      Foreign Address    State
<<sockets have disappeared here>>
    tcp        0      0 localhost:50001    localhost:35102    SYN_RECV
    tcp        0      0 localhost:50001    localhost:35103    SYN_RECV
<<snip>>
    tcp        0      0 localhost:50001    localhost:35158    SYN_RECV


=========================
OUTPUT LOG 2

    $ max_backlog -b 5 -e -w -i &
    [1] 15637
    $ Using a backlog of 5
    1: connect of fd 4 returned 0 at 15:52:21
            Port is 35170
    2: connect of fd 5 returned 0 at 15:52:21
            Port is 35171
    3: connect of fd 6 returned 0 at 15:52:21
            Port is 35172
    4: connect of fd 7 returned 0 at 15:52:21
            Port is 35173
    5: connect of fd 8 returned 0 at 15:52:21
            Port is 35174
    6: connect of fd 9 returned 0 at 15:52:21
            Port is 35175
    7: connect of fd 10 returned 0 at 15:52:21
            Port is 35176
    8: connect of fd 11 returned 0 at 15:52:21
            Port is 35177
    9: connect of fd 12 returned 0 at 15:52:30
            Port is 35178
    10: connect of fd 13 returned 0 at 15:52:30
            Port is 35179
    11: connect of fd 14 returned 0 at 15:52:39
            Port is 35180
    12: connect of fd 15 returned 0 at 15:52:39
            Port is 35181
    13: connect of fd 16 returned 0 at 15:52:48
            Port is 35182
<<snip>>
    23: connect of fd 26 returned 0 at 15:53:33
            Port is 35192
    24: connect of fd 27 returned 0 at 15:53:33
            Port is 35193
    netstat | egrep '(50001|For)' | sort +3
    Proto Recv-Q Send-Q Local Address      Foreign Address   State
    tcp        0      0 localhost:35170   localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35171   localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35172   localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35173   localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35174   localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35175   localhost:50001    ESTABLISHED
    tcp        0     18 localhost:35176   localhost:50001    ESTABLISHED
    tcp        0     17 localhost:35177   localhost:50001    ESTABLISHED
    tcp        0     16 localhost:35178   localhost:50001    ESTABLISHED
    tcp        0     15 localhost:35179   localhost:50001    ESTABLISHED
    tcp        0     14 localhost:35180   localhost:50001    ESTABLISHED
    tcp        0     13 localhost:35181   localhost:50001    ESTABLISHED
    tcp        0     12 localhost:35182   localhost:50001    ESTABLISHED
    tcp        0     11 localhost:35183   localhost:50001    ESTABLISHED
<<snip>>
    tcp        0      3 localhost:35191   localhost:50001    ESTABLISHED
    tcp        0      2 localhost:35192   localhost:50001    ESTABLISHED
    tcp        0      1 localhost:35193   localhost:50001    ESTABLISHED
    tcp        0      1 localhost:35194   localhost:50001    SYN_SENT
    tcp       24      0 localhost:50001   localhost:35170    ESTABLISHED
    tcp       23      0 localhost:50001   localhost:35171    ESTABLISHED
    tcp       22      0 localhost:50001   localhost:35172    ESTABLISHED
    tcp       21      0 localhost:50001   localhost:35173    ESTABLISHED
    tcp       20      0 localhost:50001   localhost:35174    ESTABLISHED
    tcp       19      0 localhost:50001   localhost:35175    ESTABLISHED
    tcp        0      0 localhost:50001   localhost:35176    SYN_RECV
    tcp        0      0 localhost:50001   localhost:35177    SYN_RECV
    tcp        0      0 localhost:50001   localhost:35178    SYN_RECV
    tcp        0      0 localhost:50001   localhost:35179    SYN_RECV
    tcp        0      0 localhost:50001   localhost:35180    SYN_RECV
    tcp        0      0 localhost:50001   localhost:35181    SYN_RECV
    tcp        0      0 localhost:50001   localhost:35182    SYN_RECV
<<snip>>
    tcp        0      0 localhost:50001   localhost:35192    SYN_RECV
    tcp        0      0 localhost:50001   localhost:35193    SYN_RECV
    $ 25: connect of fd 28 returned 0 at 15:53:42
            Port is 35194
    26: connect of fd 29 returned 0 at 15:53:42
            Port is 35195
    27: connect of fd 30 returned 0 at 15:53:51
            Port is 35196
<<snip>>
    71: connect of fd 74 returned 0 at 15:55:48
            Port is 35240
    72: connect of fd 75 returned 0 at 15:55:57
            Port is 35241
    SO_ERROR fd=10: error=104 (Connection reset by peer)
    ERROR [Broken pipe] write: 10
    SO_ERROR fd=11: error=104 (Connection reset by peer)
    ERROR [Broken pipe] write: 11
    73: connect of fd 76 returned 0 at 15:55:57
            Port is 35244
    74: connect of fd 77 returned 0 at 15:56:06
            Port is 35245
    SO_ERROR fd=12: error=104 (Connection reset by peer)
    ERROR [Broken pipe] write: 12
    SO_ERROR fd=13: error=104 (Connection reset by peer)
    ERROR [Broken pipe] write: 13
    75: connect of fd 78 returned 0 at 15:56:06
            Port is 35248
    76: connect of fd 79 returned 0 at 15:56:15
            Port is 35249
    SO_ERROR fd=14: error=104 (Connection reset by peer)
    ERROR [Broken pipe] write: 14
    SO_ERROR fd=15: error=104 (Connection reset by peer)
    ERROR [Broken pipe] write: 15
    77: connect of fd 80 returned 0 at 15:56:15
            Port is 35252
    netstat | egrep '(50001|For)' | sort +3
    Proto Recv-Q Send-Q Local Address      Foreign Address   State
    tcp        0      0 localhost:35170   localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35171   localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35172   localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35173   localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35174   localhost:50001    ESTABLISHED
    tcp        0      0 localhost:35175   localhost:50001    ESTABLISHED
    tcp        0     65 localhost:35182   localhost:50001    ESTABLISHED
    tcp        0     64 localhost:35183   localhost:50001    ESTABLISHED
    tcp        0     63 localhost:35184   localhost:50001    ESTABLISHED
    tcp        0     62 localhost:35185   localhost:50001    ESTABLISHED
    tcp        0     61 localhost:35186   localhost:50001    ESTABLISHED
    tcp        0     60 localhost:35187   localhost:50001    ESTABLISHED
    tcp        0     59 localhost:35188   localhost:50001    ESTABLISHED
    tcp        0     58 localhost:35189   localhost:50001    ESTABLISHED
    tcp        0     57 localhost:35190   localhost:50001    ESTABLISHED
<<snip>>
    tcp        0      2 localhost:35249   localhost:50001    ESTABLISHED
    tcp        0      1 localhost:35252   localhost:50001    ESTABLISHED
    tcp        0      1 localhost:35253   localhost:50001    SYN_SENT
    tcp       77      0 localhost:50001   localhost:35170    ESTABLISHED
    tcp       76      0 localhost:50001   localhost:35171    ESTABLISHED
    tcp       75      0 localhost:50001   localhost:35172    ESTABLISHED
    tcp       74      0 localhost:50001   localhost:35173    ESTABLISHED
    tcp       73      0 localhost:50001   localhost:35174    ESTABLISHED
    tcp       72      0 localhost:50001   localhost:35175    ESTABLISHED
<<sockets have disappeared here>>
    tcp        0      0 localhost:50001   localhost:35186    SYN_RECV
    tcp        0      0 localhost:50001   localhost:35188    SYN_RECV
    tcp        0      0 localhost:50001   localhost:35189    SYN_RECV
<<snip>>
    tcp        0      0 localhost:50001   localhost:35249    SYN_RECV
    tcp        0      0 localhost:50001   localhost:35252    SYN_RECV


=========================
TEST PROGRAM

#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/un.h>
#include <time.h>
#include <errno.h>
#include <stdio.h>
#include <stdarg.h>

char *          /* Display curent time formatted according to 'fmt' */
currTime(char *fmt)
{
    time_t t;
    size_t s;
    static char buf[1000];      /* Non-reentrant */

    t = time(NULL);
    s = strftime(buf, sizeof(buf), (fmt != NULL) ? fmt : "%c",
                 localtime(&t));

    return (s == 0) ? NULL : buf;
} /* currTime */

/* Error diagnostic routines */

static void
displayErrnoString(void)
{
    fflush(stdout);         /* First flush any pending stdout */
    fprintf(stderr, "ERROR [%s] ", strerror(errno));
} /* displayErrnoString */

void
errMsg(const char *format, ...)
{
    va_list     argList;

    displayErrnoString();

    va_start(argList, format);
    vfprintf(stderr, format, argList);
    fprintf(stderr, "\n");
    va_end(argList);
} /* errMsg */

/* Diagnose a system call error and terminate the process */

void
errExit(const char *format, ...)
{
    va_list     argList;

    displayErrnoString();

    va_start(argList, format);
    vfprintf(stderr, format, argList);
    fprintf(stderr, "\n");
    va_end(argList);

    abort();
} /* errExit */

static void
usageError(char *prog, char *msg)
{
    if (msg != NULL)
        printf("%s", msg);

    fprintf(stderr,
           "Usage: %s [options] -u backlog [path]\n"
           "   or: %s [options] -i backlog [port]\n", prog, prog);
    fprintf(stderr, "options:\n");
    fprintf(stderr, "\t-e          check for pending errors on all
sockets\n"
                    "\t            after each successful connect()\n");
    fprintf(stderr, "\t-w          write a byte on all sockets\n"
                    "\t            after each successful connect()\n");
    fprintf(stderr, "\t-b backlog  specify backlog for listen()\n");

    exit(EXIT_FAILURE);
} /* usageError */

int
main(int argc, char *argv[])
{
    int domain, sfd, cfd, s;
    struct sockaddr_in sv_inaddr;
    struct sockaddr_un sv_unaddr;
    int do_error_check, do_write, opt, res;
    int backlog;
    char *path;
#define MAX_SOCK 10000
    int fd[MAX_SOCK], write_ok[MAX_SOCK];

    /* Pare command line */

    do_error_check = 0;
    do_write = 0;
    domain = AF_UNSPEC;
    backlog = 5;

    while ((opt = getopt(argc, argv, "iuewb:")) != -1) {
        switch (opt) {
        case 'i': domain = AF_INET;             break;
        case 'u': domain = AF_UNIX;             break;
        case 'e': do_error_check = 1;           break;
        case 'w': do_write = 1;                 break;
        case 'b': backlog = atoi(optarg);       break;
        default:  usageError(argv[0], NULL);
        } /* switch */
    } /* while */

    if (domain == AF_UNSPEC)
        usageError(argv[0], "One of -i or -u must be spcified\n");

    /* Get EPIPE on write with no peer, rather than SIGPIPE */

    if (signal(SIGPIPE, SIG_IGN) == SIG_ERR) errExit("signal");

    /* Create server socket, bind(), and listen() */

    sfd = socket(domain, SOCK_STREAM, 0);
    if (sfd == -1) errExit("socket");

    if (domain == AF_UNIX) {
        path = (argc > optind + 1) ? argv[optind + 1] : "/tmp/test-sock";
        printf("path=%s\n", path);
        unlink(path);

        memset(&sv_unaddr, 0, sizeof(sv_unaddr));
        sv_unaddr.sun_family = AF_UNIX;
        strcpy(sv_unaddr.sun_path, path);

        if (bind(sfd, (struct sockaddr *) &sv_unaddr,
                    sizeof(sv_unaddr)) == -1) errExit("bind");

    } else { /* AF_INET */
        memset(&sv_inaddr, 0, sizeof(sv_inaddr));
        sv_inaddr.sin_family = AF_INET;
        sv_inaddr.sin_addr.s_addr = ntohl(INADDR_ANY);
        sv_inaddr.sin_port = ntohs((argc > optind + 1) ?
                atoi(argv[optind + 1]) : 50001);

        if (bind(sfd, (struct sockaddr *) &sv_inaddr,
                    sizeof(sv_inaddr)) == -1) errExit("bind");
    } /* if */

    printf("Using a backlog of %d\n", backlog);

    if (listen(sfd, backlog) == -1) errExit("listen");

    if (domain == AF_INET)      /* Setup address struct for connect() */
        sv_inaddr.sin_addr.s_addr = ntohl(INADDR_LOOPBACK);

    for (s = 1; ; s++) {
        cfd = socket(domain, SOCK_STREAM, 0);
        if (cfd == -1) errExit("socket - cfd");

        if (domain == AF_UNIX)
            res = connect(cfd, (struct sockaddr *) &sv_unaddr,
                        sizeof(sv_unaddr));
        else
            res = connect(cfd, (struct sockaddr *) &sv_inaddr,
                        sizeof(sv_inaddr));

        if (res == -1) errExit("connect cfd=%d", cfd);

        printf("%d: connect of fd %d returned %d at %s\n", s, cfd, res,
                currTime("%T"));

        /* If AF_INET, then display port number of peer socket */

        if (domain == AF_INET) {
            struct sockaddr_in addr;
            int addrlen;

            addrlen = sizeof(addr);
            if (getsockname(cfd, (struct sockaddr *) &addr, &addrlen) == -1)
                errExit("getsockname");
            printf("\tPort is %d\n", ntohs(addr.sin_port));
        } /* if */

        /* If -e or -w was specified, then each time round the loop,
           check for pending errors on each socket, and write to all
           sockets except those on which we previously got EPIPE. */

        if (do_error_check || do_write) {
            int j, r;
            int val, len;

            fd[s] = cfd;
            write_ok[s] = 1;

            for (j = 1; j <= s; j++) {

                if (do_error_check) {
                    len = sizeof(val);
                    if (getsockopt(fd[j], SOL_SOCKET, SO_ERROR,
                            &val, &len) == -1) errMsg("getsockopt");
                    else
                        if (val != 0)
                            printf("SO_ERROR fd=%d: error=%d (%s)\n",
                                    fd[j], val, strerror(val));
                } /* if */

                if (do_write && write_ok[j]) {
                    r = write(fd[j], "X", 1);
                    if (r == -1) {
                        if (errno != EPIPE)
                            errExit("write: %d", fd[j]);

                        errMsg("write: %d", fd[j]);
                        write_ok[j] = 0;

                        usleep(30000);  /* Slow things down a little */
                    } else if (r != 1)
                        printf("partial write %d - %d\n", fd[j], r);
                } /* if */
            } /* for */
        }  /* if */
    } /* for */
} /* main */



-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

