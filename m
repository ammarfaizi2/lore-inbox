Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131446AbRDSQlX>; Thu, 19 Apr 2001 12:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131424AbRDSQlO>; Thu, 19 Apr 2001 12:41:14 -0400
Received: from user-vc8ftn3.biz.mindspring.com ([216.135.246.227]:24845 "EHLO
	mail.ivivity.com") by vger.kernel.org with ESMTP id <S131323AbRDSQlC>;
	Thu, 19 Apr 2001 12:41:02 -0400
Message-ID: <25369470B6F0D41194820002B328BDD27C93@ATLOPS>
From: Marc Karasek <marc_karasek@ivivity.com>
Reply-To: root@chaos.analogic.com
To: "'Richard B. Johnson '" <root@chaos.analogic.com>,
        Marc Karasek <marc_karasek@ivivity.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Bug in serial.c 
Date: Thu, 19 Apr 2001 12:18:26 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think maybe we have a miscommunication here..  I am not running any apps
(yet) all I am trying to do is get it to boot up under 2.4.3.  The
apps/daemons/modules are the next step.  I am just booting the standard
kernel to a login prompt.  (I am usng busybox for init.)  Before a login
prompt a script is run as part of inittab to setup the eth0 port, etc...
This requires some input from the console (in this case ttyS0).  It is at
this point that 2.4.2 works (accepts input and lets the script continue)
2.4.3 just sits there, you can bang on the keys all you want :-(  


Also, I did a diff between serial.c in 2.4.2 & 2.4.3 and there are a lot of
changes...  

 

-----Original Message-----
From: Richard B. Johnson
To: Marc Karasek
Sent: 4/19/01 12:07 PM
Subject: RE: Bug in serial.c 

On Thu, 19 Apr 2001, Marc Karasek wrote:

>  Did something change between 2.4.2 & 2.4.3? Under 2.4.2 I did not
have to
> init the terminal (are you refering to the host or client side?) and
just
> accepted the defaults (9600, 8n1) which was fine for debug and
terminal I/O.
> 
> 
> My issue is with 2.4.2 it works with 2.4.3 (same .config) it does not.
So
> in my mind this is a bug of some type.....  :-) 
> 
> Which kernel are you using in your embedded project??
> 

I have conditional compiles for 2.2.17 to 2.2.19 plus 2.4.1, 2.4.2,
2.4.3, 2.4.4-pre(something, maybe 4).

There have been a lot of changes (and bugs), but Serial TTY I/O has
not been one of them -- and I use RS-232C with ANSI escape sequences
(vt101 DEC), because we don't have a screen-card or a keyboard. I
would have been first to notice.

Of course my code DID initialize the terminal from the start, if yours
didn't, the defaults may have changed. There was an old bug with
flow-control (an X-OFF stuck-state), that required the terminal
to opened and closed twice to clear. I still have the work-around
in the init code.


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-=-*/
/*
 *  Since we __are__ init, we have to everything that is necessary to
 *  startup and maintain the system.
 */
int main(int argc, char *argv[])
{
    MEM *mem;
    size_t i;
    int fd, flags;
    speed_t baud;
    if((mem = (MEM *) malloc(sizeof(MEM))) == NULL)
        ERRORS(Malloc);
    strcpy(argv[0], "Platinum");
    argv[0] = mem->argv0;
    argv[1] = mem->argv1;
    argv[2] = NULL;
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-=-*/
/*
 *  We may have failed to open an initial console. Therefore, we do the
 *  terminal stuff over from scratch.
 */
    clr(&mem->st,  sizeof(struct termios));
    mem->st.c_cc[VINTR]    = (char) 'C' - 64;
    mem->st.c_cc[VQUIT]    = (char) '\\'- 64;
    mem->st.c_cc[VERASE]   = (char) '?' + 64;
    mem->st.c_cc[VKILL]    = (char) 'U' - 64;
    mem->st.c_cc[VEOF]     = (char) 'D' - 64;
    mem->st.c_cc[VTIME]    = (char)  0;
    mem->st.c_cc[VMIN]     = (char)  1;
    mem->st.c_cc[VSWTC]    = (char) '@' - 64;
    mem->st.c_cc[VSTART]   = (char) 'Q' - 64;
    mem->st.c_cc[VSTOP]    = (char) 'S' - 64;
    mem->st.c_cc[VSUSP]    = (char) 'Z' - 64;
    mem->st.c_cc[VEOL]     = (char) '@' - 64;
    mem->st.c_cc[VREPRINT] = (char) 'R' - 64;
    mem->st.c_cc[VDISCARD] = (char) 'O' - 64;
    mem->st.c_cc[VWERASE]  = (char) 'W' - 64;
    mem->st.c_cc[VLNEXT]   = (char) 'V' - 64;
    mem->st.c_cc[VEOL2]    = (char) '@' - 64;
    mem->st.c_oflag = OPOST|ONLCR;
    mem->st.c_iflag = ICRNL|IXON;
    mem->st.c_lflag =
ISIG|ICANON|ECHO|ECHOE|ECHOK|ECHOCTL|ECHOKE|IEXTEN;
    mem->st.c_cflag = B9600|CS8|CREAD|HUPCL|CLOCAL;
/*
 *  Because of a bug in the Linux 2.4.0 terminal driver, we have to do
 *  this twice to get the flow-control turned off.
 */
    for(i=0; i< 2; i++)
    {
        (void)close(STDIN_FILENO);
        (void)close(STDOUT_FILENO);
        (void)close(STDERR_FILENO);
        if((fd = open(stdcmd, O_RDWR|O_NDELAY, 0)) < 0)
            fd = open(Altcons, O_RDWR|O_NDELAY);
        if((flags = fcntl(fd, F_GETFL, 0)) == FAIL)
            ERRORS(Fcntl);
        flags &= ~O_NDELAY;
        if(fcntl(fd, F_SETFL, flags) == FAIL)
            ERRORS(Fcntl);
        if(!!fd)
        {
            if(dup2(fd, STDIN_FILENO) == FAIL)
                ERRORS(Dup2);
            if(dup2(fd, STDOUT_FILENO) == FAIL)
                ERRORS(Dup2);
            if(dup2(fd, STDERR_FILENO) == FAIL)
                ERRORS(Dup2);
            if(fd > 2) (void)close(fd);
        }
        else                         /* fd is STDIN_FILENO  */
        {
            if(dup(fd) == FAIL)      /* Make STDOUT_FILENO  */
                ERRORS(Dup);
            if(dup(fd) == FAIL)      /* Make STDERR_FILENO  */
                ERRORS(Dup);
        }
        if(tcflush(STDIN_FILENO, TCIFLUSH) < 0)
            ERRORS(Tcflush);
        if(tcsetattr(STDIN_FILENO, TCSANOW, &mem->st) < 0)
            ERRORS(Tcsetattr);
    }



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.

