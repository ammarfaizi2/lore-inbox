Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268066AbUH2QXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268066AbUH2QXW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268080AbUH2QXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:23:22 -0400
Received: from holomorphy.com ([207.189.100.168]:18350 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268066AbUH2QW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:22:58 -0400
Date: Sun, 29 Aug 2004 09:22:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: mita akinobu <amgta@yacht.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, Andries Brouwer <aeb@cwi.nl>,
       Alessandro Rubini <rubini@ipvvis.unipv.it>
Subject: Re: [util-linux] readprofile ignores the last element in /proc/profile
Message-ID: <20040829162252.GG5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
	Andries Brouwer <aeb@cwi.nl>,
	Alessandro Rubini <rubini@ipvvis.unipv.it>
References: <200408250022.09878.amgta@yacht.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <200408250022.09878.amgta@yacht.ocn.ne.jp>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 25, 2004 at 12:22:09AM +0900, mita akinobu wrote:
> The readprofile command does not print the number of clock ticks about
> the last element in profiling buffer.
> Since the number of clock ticks which occur on the module functions is
> as same as the value of the last element of prof_buffer[]. when many
> ticks occur on there, some users who browsing the output of readprofile
> may overlook the fact that the bottle-neck may exist in the modules.
> I create the patch which enable to print clock ticks of the last
> element as "*unknown*".

Well, since I couldn't stop vomiting for hours after I looked at the
code for readprofile(1), here's a reimplementation, with various
misfeatures removed, included as a MIME attachment.


-- wli

--1LKvkjL3sHcu1TtY
Content-Type: text/x-csrc; charset=us-ascii
Content-Description: readprofile.c
Content-Disposition: attachment; filename="readprofile.c"

/*
 * readprofile(1) implementation.
 * (C) 2004 William Irwin, Oracle
 * Licensed under GPL, or any DFSG-free license of the user's choice.
 */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <strings.h>
#include <unistd.h>
#include <limits.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/utsname.h>

struct sym {
	unsigned long long vaddr;
	char name[64];
	unsigned long hits;
};

struct profile_state {
	int fd, shift;
	uint32_t *buf;
	size_t bufsz;
	struct sym syms[2], *last, *this;
	unsigned long long stext, vaddr;
	unsigned long total;
	char type, sym[64];
};

static int digits(void)
{
	static int ret = 0;
	unsigned long n = ULONG_MAX;

	if (ret)
		return ret;
	for (n = ULONG_MAX; n >= 10; n /= 10)
		++ret;
	ret += !!n;
	return ret;
}

static void shift_syms(struct sym *syms, struct sym **last, struct sym **this)
{
	*last = *this;
	*this = &syms[!(*this - syms)];
}

static int is_text(char c)
{
	return c == 'T' || c == 't' || c == 'W' || c == 'w';
}

static long profile_off(unsigned long long vaddr, struct profile_state *state)
{
	return (((vaddr - state->stext) >> state->shift) + 1)*sizeof(uint32_t);
}

static int state_transition(struct profile_state *state)
{
	int ret = 0;
	long page_mask, start, end;
	unsigned off;

	if (!state->stext) {
		if (!strcmp(state->sym, "_stext"))
			state->stext = state->vaddr;
		goto out;
	} else if ((!state->last || !state->this) && !is_text(state->type)) {
		ret = 1;
		goto out;
	}
	shift_syms(state->syms, &state->last, &state->this);
	state->this->vaddr = state->vaddr;
	state->this->hits = 0;
	if (is_text(state->type)) {
		strcpy(state->this->name, state->sym);
		if (!state->last)
			goto out;
	} else {
		strcpy(state->this->name, "*unknown*");
		ret = 1;
	}
	start = profile_off(state->last->vaddr, state);
	end = profile_off(state->this->vaddr, state)
					+ !!state->shift*sizeof(uint32_t);
	if (lseek(state->fd, start, SEEK_SET) != start) {
		fprintf(stderr, "fseek() failed\n");
		exit(EXIT_FAILURE);
	}
	if (state->bufsz < (size_t)(end - start)) {
		page_mask = getpagesize() - 1;
		state->bufsz = (end - start + page_mask) & ~page_mask;
		free(state->buf);
		if (!(state->buf = malloc(state->bufsz))) {
			fprintf(stderr, "out of memory\n");
			exit(EXIT_FAILURE);
		}
	}
	if (read(state->fd, state->buf, end - start) == end - start) {
		for (off = 0; off < (end - start)/sizeof(uint32_t); ++off)
			state->last->hits += state->buf[off];
	} else {
		ret = 1;
		strcpy(state->last->name, "*unknown*");
	}
	if (state->last->hits)
		printf("%*lu %s\n", digits(), state->last->hits,
							state->last->name);
	state->total += state->last->hits;
out:
	return ret;
}

static int readprofile(FILE *system_map, int profile_buffer)
{
	char *buf = NULL;
	ssize_t nchar, bufsz;
	uint32_t step;
	struct profile_state state = {
		.fd	= profile_buffer,
		.last	= NULL,
		.this	= NULL,
		.total	= 0,
		.stext	= 0,
	};

	if (read(profile_buffer, &step, sizeof(uint32_t)) != sizeof(uint32_t)) {
		fprintf(stderr, "read() failed\n");
		return EXIT_FAILURE;
	}
	state.shift = ffs(step) - 1;
	if (!(state.buf = malloc(getpagesize()))) {
		fprintf(stderr, "out of memory\n");
		return EXIT_FAILURE;
	}
	state.bufsz = getpagesize();
	while ((nchar = getline(&buf, &bufsz, system_map)) > 0) {
		if (sscanf(buf, "%Lx %c %63s", &state.vaddr, &state.type,
							state.sym) != 3)
			continue;
		if (state_transition(&state))
			break;
	}
	printf("%*lu total\n", digits(), state.total);
	if (state.buf)
		free(state.buf);
	return 0;
}

static FILE *open_system_map(void)
{
	struct utsname buf;
	char s[256];

	if (!access("/boot/System.map", R_OK))
		return fopen("/boot/System.map", "r");
	if (uname(&buf))
		return NULL;
	snprintf(s, sizeof(s), "/boot/System.map-%s", buf.release);
	return fopen(s, "r");
}

int main(int argc, char * const argv[])
{
	FILE *system_map = NULL;
	int c, ret, profile_buffer = -1;
	static const char optstr[] = "m:p:";

	while ((c = getopt(argc, argv, optstr)) != EOF) {
		switch (c) {
			case 'm':
				if (!strcmp(optarg, "-"))
					system_map = fdopen(STDIN_FILENO, "r");
				else if (!access(optarg, R_OK))
					system_map = fopen(optarg, "r");
				else {
					fprintf(stderr, "mapfile %s is "
						"inaccessible\n", optarg);
					exit(EXIT_FAILURE);
				}
				break;
			case 'p':
				if (!strcmp(optarg, "-"))
					profile_buffer = STDIN_FILENO;
				else if (!access(optarg, R_OK))
					profile_buffer = open(optarg, O_RDONLY);
				else {
					fprintf(stderr, "profile %s is "
						"inaccessible\n", optarg);
					exit(EXIT_FAILURE);
				}
				break;
			case '?':
			default:
				fprintf(stderr, "usage: %s [ -m mapfile ] "
					"[ -p profile ]\n", argv[0]);
				exit(EXIT_FAILURE);
		}
	}
	if (!system_map)
		system_map = open_system_map();
	if (profile_buffer < 0)
		profile_buffer = open("/proc/profile", O_RDONLY);
	ret = readprofile(system_map, profile_buffer);
	fclose(system_map);
	close(profile_buffer);
	return ret;
}

--1LKvkjL3sHcu1TtY--
