Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131009AbRAPUXs>; Tue, 16 Jan 2001 15:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131229AbRAPUXi>; Tue, 16 Jan 2001 15:23:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:40323 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131009AbRAPUX0>; Tue, 16 Jan 2001 15:23:26 -0500
Date: Tue, 16 Jan 2001 15:23:19 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Update on RTS/CTS serial problem with 2.4.0
Message-ID: <Pine.LNX.3.95.1010116152144.23250A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I previously reported a problem trying to disable hardware flow-control
of serial ports in the Linux kernel 2.4.0. This problem did not
exist in Linux version 2.2.18.

This problem occurs when the initial console has been redirected out
to a serial port as is the case with one of our embedded systems.

It appears that the device must be closed, i.e., nobody using the
terminal, before the CTS/RTS disabling takes affect. A work around
(that works) is to set the terminal, close it, then open and set
it again. This is basically what `setserial` does to an otherwise
unused terminal. It seems as though this should not be necessary.

Here is a snippet of code that works.

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
/*
 *  We may have failed to open an initial console. Therefore, we do the
 *  terminal stuff over from scratch.
 */
    memset(&mem->st, 0x00, sizeof(struct termios));
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
    mem->st.c_lflag = ISIG|ICANON|ECHO|ECHOE|ECHOK|ECHOCTL|ECHOKE|IEXTEN;
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
        if((flags = fcntl(fd, F_GETFL, 0)) != -1)
        {
            flags &= ~O_NDELAY;
            (void)fcntl(fd, F_SETFL, flags);
        }
        if(!!fd)
        {
            (void)dup2(fd, STDIN_FILENO);
            (void)dup2(fd, STDOUT_FILENO);
            (void)dup2(fd, STDERR_FILENO);
            if(fd > 2) (void)close(fd);
        }
        else                         /* fd is STDIN_FILENO  */
        {
            (void)dup(fd);           /* Make STDOUT_FILENO  */
            (void)dup(fd);           /* Make STDERR_FILENO  */
        }
        if(tcflush(STDIN_FILENO, TCIFLUSH) < 0)
            ERRORS(Tcflush);
        if(tcsetattr(STDIN_FILENO, TCSANOW, &mem->st) < 0)
            ERRORS(Tcsetattr);
    }

I can't see anything that I have done wrong that would otherwise
prevent this from working the first time through.

Comments?


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
