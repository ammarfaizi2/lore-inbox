Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289177AbSAGLac>; Mon, 7 Jan 2002 06:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289178AbSAGLaX>; Mon, 7 Jan 2002 06:30:23 -0500
Received: from wiproecmx1.wipro.com ([164.164.31.5]:50681 "EHLO
	wiproecmx1.wipro.com") by vger.kernel.org with ESMTP
	id <S289177AbSAGLaI>; Mon, 7 Jan 2002 06:30:08 -0500
Message-ID: <001b01c1976f$d11da6f0$4e05720a@M3HOM103042>
From: "Venkata Rajesh Velamakanni" <rajesh.venkata@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: Faced a problem with rtnetlink socket ( RTM_DELLINK)
Date: Mon, 7 Jan 2002 17:08:24 +0530
Organization: Wipro Ltd.
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0018_01C1979D.EAA36140"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0018_01C1979D.EAA36140
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello All,

I am facing a problem in using rtnetlink sockets and thought that 
this mailing list would be the better to place to clarify.  
Can anyone calrify my query.  

When I tried deleting an interface, I have received message
 RTM_NEWLINK (instead of  RTM_DELLINK) from kernel.

I have executed the attached program and did "/sbin/ifdown eth0"..
and my program received a messsage RTM_NEWLINK from kernel
instead of RTM_DELLINK.

When I  tried adding the interface "/sbin/ifup eth0".. it works fine 
and received RTM_NEWLINK.

I would like to know whether anyone has faced this problem or
am I missing something in my program.

Thanks,
Rajesh.











------=_NextPart_000_0018_01C1979D.EAA36140
Content-Type: application/octet-stream;
	name="rtnetlink.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rtnetlink.c"

#include <unistd.h>=0A=
#include <fcntl.h>=0A=
#include <errno.h>=0A=
#include <stdio.h>=0A=
#include <bits/sockaddr.h>=0A=
#include <linux/in.h>=0A=
#include <sys/types.h>=0A=
#include <sys/socket.h>=0A=
#include <linux/netlink.h>=0A=
#include <linux/rtnetlink.h>=0A=
=0A=
struct iovec=0A=
  {=0A=
    void *iov_base;     /* Pointer to data.  */=0A=
    size_t iov_len;     /* Length of data.  */=0A=
  };=0A=
=0A=
=0A=
=0A=
main()=0A=
{=0A=
=0A=
  int status;=0A=
  int ret =3D 0;=0A=
  int error;=0A=
   struct sockaddr_nl bind_addr;=0A=
   int rtnetlink_sk =3D socket(PF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);=0A=
=0A=
=0A=
    bind_addr.nl_family =3D AF_NETLINK;=0A=
    bind_addr.nl_pad =3D 0; =0A=
    bind_addr.nl_pid =3D getpid();=0A=
    bind_addr.nl_groups =3D ~0U;=0A=
    =0A=
    if (bind(rtnetlink_sk, (struct sockaddr *)&bind_addr,=0A=
            sizeof(bind_addr)) < 0) {=0A=
        perror("bind");=0A=
    }   =0A=
=0A=
  while (1)=0A=
    {=0A=
      char buf[4096];=0A=
      struct iovec iov =3D { buf, sizeof buf };=0A=
      struct sockaddr_nl snl;=0A=
      struct msghdr msg =3D { (void*)&snl, sizeof snl, &iov, 1, NULL, 0, =
0};=0A=
      struct nlmsghdr *h;=0A=
=0A=
      status =3D recvmsg (rtnetlink_sk, &msg, 0);=0A=
=0A=
      if (status < 0)=0A=
        {=0A=
          if (errno =3D=3D EINTR)=0A=
            continue;=0A=
          if (errno =3D=3D EWOULDBLOCK)=0A=
            break;=0A=
          continue;=0A=
        }=0A=
=0A=
      if (status =3D=3D 0)=0A=
        {=0A=
          return -1;=0A=
        }=0A=
=0A=
      if (msg.msg_namelen !=3D sizeof snl)=0A=
        {=0A=
          return -1;=0A=
        }=0A=
=0A=
      for (h =3D (struct nlmsghdr *) buf; NLMSG_OK (h, status);=0A=
           h =3D NLMSG_NEXT (h, status))=0A=
        {=0A=
          /* Finish of reading. */=0A=
          if (h->nlmsg_type =3D=3D NLMSG_DONE)=0A=
            return ret;=0A=
=0A=
          /* Error handling. */=0A=
          if (h->nlmsg_type =3D=3D NLMSG_ERROR)=0A=
            {=0A=
              struct nlmsgerr *err =3D (struct nlmsgerr *) NLMSG_DATA =
(h);=0A=
              if (h->nlmsg_len < NLMSG_LENGTH (sizeof (struct nlmsgerr)))=0A=
                {=0A=
=0A=
					printf("Received error message that to with invalid length\n");=0A=
                	return ;=0A=
               }=0A=
=0A=
              return ;=0A=
            }=0A=
=0A=
          /* OK we received netlink message. */=0A=
=0A=
  		switch (h->nlmsg_type)=0A=
    	{=0A=
    		case RTM_NEWLINK:=0A=
			{=0A=
	  			printf("We are in NEWLINK ...\n");=0A=
      			break; =0A=
			}=0A=
    		case RTM_DELLINK:=0A=
			{=0A=
	  			printf("We are in DELLINK ...\n");=0A=
      			break; =0A=
			}=0A=
    		default: =0A=
      		break;=0A=
    	} =0A=
	}=0A=
=0A=
      /* After error care. */=0A=
      if (msg.msg_flags & MSG_TRUNC)=0A=
        {=0A=
          continue;=0A=
        }=0A=
      if (status)=0A=
        {=0A=
          return -1;=0A=
        }=0A=
    }=0A=
  return ret;=0A=
}=0A=
=0A=


------=_NextPart_000_0018_01C1979D.EAA36140
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

-----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
------------------------------------------------------------------------------------------------------------------------

------=_NextPart_000_0018_01C1979D.EAA36140--

