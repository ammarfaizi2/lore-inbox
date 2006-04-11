Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWDKPS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWDKPS0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 11:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWDKPS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 11:18:26 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:36483 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751354AbWDKPSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 11:18:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=i1DOC6yBPs7bD2rndvT/b+otAOMcNpOefLvwdTv58D2M0w2YSpz2WECPN5cv5EVhdlILoQ2fDORwzK5d9KvqiMC8xP8wusDuj0ItyAEXycm4mERZDPqVDkoX+03O2OPKW9g+nF+3hXIwCNbs7OHHXdhl1Ygz716oHb5Rv2NHCOc=
Message-ID: <443BC8C2.906@gmail.com>
Date: Tue, 11 Apr 2006 23:18:26 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [ANNOUNCE] Test Program for Filesystem Events Reporter
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This program is used to test Filesystem Events Reporter, you
can modify it in the fly to stress Filesystem Events Reporter
or check boundary condition processing logic.

Your feedback is welcome.

/*
 * fsevent_test.c - Filesystem Events Reporter Userspace Test Program
 * created by Yi Yang <yang.y.yi@gmail.com>
 */

#include <sys/types.h>
#include <sys/socket.h>
#include <signal.h>
#include <linux/netlink.h>
#define _LINUX_TIME_H
#include <linux/fsevent.h>

#define MAX_MSGSIZE 1024
#ifndef SOL_NETLINK
#define SOL_NETLINK 270
#endif
#define MATCH_FSEVENT_TYPE(t1, t2) (((t1) & (t2)) == (t2))

int sd;
struct sockaddr_nl l_local, daddr;
int on;
int len;
struct nlmsghdr *nlhdr = NULL;
struct msghdr msg;
struct iovec iov;
struct fsevent_filter * filter;
struct cn_msg * cnmsg;
struct fsevent * fsevent;
int counter = 0;
int ret;
struct sigaction sigint_action;
enum fsevent_type type;

void set_fsevent_filter(unsigned int mask, int control, int type, int id)
{
	memset(nlhdr, 0, sizeof(NLMSG_SPACE(MAX_MSGSIZE)));
	memset(&iov, 0, sizeof(struct iovec));
	memset(&msg, 0, sizeof(struct msghdr));
        filter = (struct fsevent_filter *)NLMSG_DATA(nlhdr);
        filter->mask = mask;
	if (type != FSEVENT_FILTER_ALL) {
		filter->id.pid = id;
	}
	filter->type = type;
	filter->control = control;

        nlhdr->nlmsg_len = NLMSG_LENGTH(sizeof(struct fsevent_filter));
        nlhdr->nlmsg_pid = getpid();
        nlhdr->nlmsg_flags = 0;
        nlhdr->nlmsg_type = NLMSG_DONE;
        nlhdr->nlmsg_seq = 0;

        iov.iov_base = (void *)nlhdr;
        iov.iov_len = nlhdr->nlmsg_len;
        msg.msg_name = (void *)&daddr;
        msg.msg_namelen = sizeof(daddr);
        msg.msg_iov = &iov;
        msg.msg_iovlen = 1;
        ret = sendmsg(sd, &msg, 0);
        if (ret == -1) {
        	perror("sendmsg error:");
		exit(-1);
        }
}

int get_fsevent()
{

	memset(nlhdr, 0, NLMSG_SPACE(MAX_MSGSIZE));
	memset(&iov, 0, sizeof(struct iovec));
	memset(&msg, 0, sizeof(struct msghdr));

        iov.iov_base = (void *)nlhdr;
        iov.iov_len = NLMSG_SPACE(MAX_MSGSIZE);
        msg.msg_name = (void *)&daddr;
        msg.msg_namelen = sizeof(daddr);
        msg.msg_iov = &iov;
        msg.msg_iovlen = 1;

        return recvmsg(sd, &msg, 0);
}

void stop_listen()
{
	set_fsevent_filter(0xffffffff, FSEVENT_FILTER_IGNORE,
				FSEVENT_FILTER_ALL,0);
	set_fsevent_filter(0xffffffff, FSEVENT_FILTER_REMOVE,
				FSEVENT_FILTER_ALL,0);
}

void sigint_handler(int signo)
{
	stop_listen();
	printf("filesystem event: turn off filesystem event listening.\n");
	get_fsevent();
	get_fsevent();
	close(sd);
	exit(0);
}

void print_fsevent(struct fsevent * event, char * typestr, int flag)
{
	printf("filesystem event: %s\n"
		"process '%s' %s %s '%s'",
		typestr,
		fsevent->name,
		typestr,
		((fsevent->type & FSEVENT_ISDIR)
			== FSEVENT_ISDIR)?"dir":"file",
		fsevent->name + fsevent->pname_len + 1);
	if (flag)
		printf(" to '%s'", fsevent->name + fsevent->pname_len
                                        + fsevent->fname_len + 2);
	printf("\n");

}

void print_ack(char * typestr)
{
	printf("filesystem event: "
		"acknowledge for filter on %s\n", typestr);
}

int main(void)
{

	memset(&sigint_action, 0, sizeof(struct sigaction));
	sigint_action.sa_flags = SA_ONESHOT;
	sigint_action.sa_handler = &sigint_handler;
	sigaction(SIGINT, &sigint_action, NULL);
	nlhdr = (struct nlmsghdr *)malloc(NLMSG_SPACE(MAX_MSGSIZE));
	if (nlhdr == NULL) {
		perror("malloc:");
		exit(-1);
	}

	daddr.nl_family = AF_NETLINK;
        daddr.nl_pid = 0;
        daddr.nl_groups = 0;
	
	sd = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_FSEVENT);

	l_local.nl_family = AF_NETLINK;
	l_local.nl_groups = 0;
	l_local.nl_pid = getpid();

	if (bind(sd, (struct sockaddr *)&l_local,
			sizeof(struct sockaddr_nl)) == -1) {
        	perror("bind");
	        close(sd);
        	return -1;
	}

	set_fsevent_filter(FSEVENT_MOUNT|FSEVENT_UMOUNT,
			FSEVENT_FILTER_LISTEN, FSEVENT_FILTER_ALL, 0);
	printf("filesystem event: turn on filesystem event listening.\n");

	while (1) {
		ret = get_fsevent();
                if (ret == 0) {
                        printf("Exit.\n");
                        exit(0);
                }

                if (ret == -1) {
                        perror("recvmsg:");
                        exit(1);
                }

		fsevent = (struct fsevent *)NLMSG_DATA(nlhdr);
		type = fsevent->type;
		if (MATCH_FSEVENT_TYPE(type, FSEVENT_ACCESS))
			print_fsevent(fsevent, "access", 0);
		if (MATCH_FSEVENT_TYPE(type, FSEVENT_MODIFY))
			print_fsevent(fsevent, "modify", 0);
		if (MATCH_FSEVENT_TYPE(type, FSEVENT_MODIFY_ATTRIB))
			print_fsevent(fsevent, "modify_attr", 0);
		if (MATCH_FSEVENT_TYPE(type, FSEVENT_CLOSE))
			print_fsevent(fsevent, "close", 0);
		if (MATCH_FSEVENT_TYPE(type, FSEVENT_OPEN))
			print_fsevent(fsevent, "open", 0);
		if (MATCH_FSEVENT_TYPE(type, FSEVENT_MOVE))
			print_fsevent(fsevent, "move", 1);
		if (MATCH_FSEVENT_TYPE(type, FSEVENT_CREATE))
			print_fsevent(fsevent, "create", 0);
		if (MATCH_FSEVENT_TYPE(type, FSEVENT_DELETE))
			print_fsevent(fsevent, "delete", 0);
		if (MATCH_FSEVENT_TYPE(type, FSEVENT_MOUNT))
			print_fsevent(fsevent, "mount", 1);
		if (MATCH_FSEVENT_TYPE(type, FSEVENT_UMOUNT))
			print_fsevent(fsevent, "umount", 0);
		if (MATCH_FSEVENT_TYPE(type, FSEVENT_FILTER_ALL))
			print_ack("all");
		if (MATCH_FSEVENT_TYPE(type, FSEVENT_FILTER_PID))
			print_ack("pid");
		if (MATCH_FSEVENT_TYPE(type, FSEVENT_FILTER_UID))
			print_ack("uid");
		if (MATCH_FSEVENT_TYPE(type, FSEVENT_FILTER_GID))
			print_ack("gid");
		printf("event type = %08x, pid = %d, uid = %d, gid = %d\n",
			fsevent->type, fsevent->pid,
			fsevent->uid, fsevent->gid);
		printf("counter = %d\n\n", counter++);
	}
}


