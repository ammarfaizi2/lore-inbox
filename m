Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264067AbRFROhL>; Mon, 18 Jun 2001 10:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264120AbRFROhB>; Mon, 18 Jun 2001 10:37:01 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:40715 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S264067AbRFROgv>; Mon, 18 Jun 2001 10:36:51 -0400
To: linux-kernel@vger.kernel.org
Subject: problem with write() to a socket and EPIPE
From: oliver.kowalke@t-online.de
Date: Mon, 18 Jun 2001 16:36:23 +0200 (MEST)
Message-ID: <992874658.3b2e10a2ef441@webmail.t-online.de>
X-Priority: 3 (Normal)
X-Mailer: T-Online WebMail 2.00
X-Complaints-To: abuse#webmail@t-online.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've the following problem.
If the peer has closed its socket connection the second write to this 
socket should return -1 and errno should be set to EPIPE (if SIGPIPE is 
set  
to be ignored). This never happens with my code. Why?

OS: Linux (Debian 2.2r3)
kernel: 2.4.4
compiler: gcc-2.95.2
c-lib: libc-2.1.3

with best regards,
Oliver

(writen() is a member function of my socket C++-class)

ssize_t
sock::writen( const void * vptr, size_t n)
{
        size_t          nleft;
        ssize_t         nwritten;
        const char      *ptr;

        ptr = static_cast< char * >( vptr);
        nleft = n;

        struct sigaction new_sa;
        struct sigaction old_sa;
        
        new_sa.sa_handler = SIG_IGN;
        ::sigemptyset( & new_sa.sa_mask);
        new_sa.sa_flags = 0;
        ::sigaction( SIGPIPE, & new_sa, & old_sa);              

        while ( nleft > 0)
        {
                if ( ( nwritten = ::write( m_handle, ptr, nleft) ) <= 
0) 
                {
                        if ( errno == EINTR)

                                nwritten = 0;           /* and call 
write() again */ 

                        else if ( errno == EPIPE)

                                return EOF;             /* write to 
socket with no readers */ 

                        else

                                throw net_io_ex( ::strerror( errno), 
"writen()", __FILE__);     /* error */ 

                }

                nleft -= nwritten;
                ptr   += nwritten;
        }
        /* set to its previous action */
        ::sigaction( SIGPIPE, & old_sa, 0);

        return n;
}
