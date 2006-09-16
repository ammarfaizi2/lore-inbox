Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751730AbWIPHy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbWIPHy4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 03:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWIPHy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 03:54:56 -0400
Received: from tomts40.bellnexxia.net ([209.226.175.97]:25218 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751730AbWIPHyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 03:54:54 -0400
Date: Sat, 16 Sep 2006 03:54:49 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>
Subject: [PATCH 6/11] LTTng-core 0.5.111 : Relay+DebugFS
Message-ID: <20060916075449.GG29360@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-17099-1158393289-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 03:54:13 up 24 days,  5:02,  4 users,  load average: 0.88, 0.38, 0.18
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-17099-1158393289-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

6 - Core tracer facility headers
patch-2.6.17-lttng-core-0.5.111-facilities-headers.diff

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-17099-1158393289-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-core-0.5.111-facilities-headers.diff"

--- /dev/null
+++ b/include/linux/ltt/ltt-facility-core.h
@@ -0,0 +1,850 @@
+#ifndef _LTT_FACILITY_CORE_H_
+#define _LTT_FACILITY_CORE_H_
+
+#include <linux/types.h>
+#include <linux/ltt/ltt-facility-id-core.h>
+#include <linux/ltt-core.h>
+
+/* Named types */
+
+/* Event facility_load structures */
+static inline void lttng_write_string_core_facility_load_name(
+		char *buffer,
+		size_t *to_base,
+		size_t *to,
+		const char **from,
+		size_t *len,
+		const char * obj)
+{
+	size_t size;
+	size_t align;
+
+	/* Flush pending memcpy */
+	if(*len != 0) {
+		if(buffer != NULL)
+			memcpy(buffer+*to_base+*to, *from, *len);
+	}
+	*to += *len;
+	*len = 0;
+
+	align = sizeof(char);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	/* Contains variable sized fields : must explode the structure */
+
+	size = strlen(obj) + 1; /* Include final NULL char. */
+	if(buffer != NULL)
+		memcpy(buffer+*to_base+*to, obj, size);
+	*to += size;
+
+	/* Realign the *to_base on arch size, set *to to 0 */
+	*to += ltt_align(*to, sizeof(void *));
+	*to_base = *to_base+*to;
+	*to = 0;
+
+	/* Put source *from just after the C string */
+	*from += size;
+}
+
+
+/* Event facility_load logging function */
+static inline void trace_core_facility_load(
+		const char * lttng_param_name,
+		unsigned int lttng_param_checksum,
+		unsigned int lttng_param_id,
+		unsigned int lttng_param_int_size,
+		unsigned int lttng_param_long_size,
+		unsigned int lttng_param_pointer_size,
+		unsigned int lttng_param_size_t_size,
+		unsigned int lttng_param_has_alignment)
+#if (!defined(CONFIG_LTT) || !defined(CONFIG_LTT_FACILITY_CORE))
+{
+}
+#else
+{
+	unsigned int index;
+	struct ltt_channel_struct *channel;
+	struct ltt_trace_struct *trace;
+	void *transport_data;
+	char *buffer = NULL;
+	size_t real_to_base = 0; /* The buffer is allocated on arch_size alignment */
+	size_t *to_base = &real_to_base;
+	size_t real_to = 0;
+	size_t *to = &real_to;
+	size_t real_len = 0;
+	size_t *len = &real_len;
+	size_t reserve_size;
+	size_t slot_size;
+	size_t align;
+	const char *real_from;
+	const char **from = &real_from;
+	u64 tsc;
+	size_t before_hdr_pad, after_hdr_pad, header_size;
+
+	if(ltt_traces.num_active_traces == 0) return;
+
+	/* For each field, calculate the field size. */
+	/* size = *to_base + *to + *len */
+	/* Assume that the padding for alignment starts at a
+	 * sizeof(void *) address. */
+
+	*from = (const char*)lttng_param_name;
+	lttng_write_string_core_facility_load_name(buffer, to_base, to, from, len, lttng_param_name);
+
+	*from = (const char*)&lttng_param_checksum;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	*from = (const char*)&lttng_param_id;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	*from = (const char*)&lttng_param_int_size;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	*from = (const char*)&lttng_param_long_size;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	*from = (const char*)&lttng_param_pointer_size;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	*from = (const char*)&lttng_param_size_t_size;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	*from = (const char*)&lttng_param_has_alignment;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	reserve_size = *to_base + *to + *len;
+	preempt_disable();
+	ltt_nesting[smp_processor_id()]++;
+	index = ltt_get_index_from_facility(ltt_facility_core_1A8DE486,
+						event_core_facility_load);
+
+	list_for_each_entry_rcu(trace, &ltt_traces.head, list) {
+		if(!trace->active) continue;
+
+		channel = ltt_get_channel_from_index(trace, index);
+
+		slot_size = 0;
+		buffer = ltt_reserve_slot(trace, channel, &transport_data,
+			reserve_size, &slot_size, &tsc,
+			&before_hdr_pad, &after_hdr_pad, &header_size);
+		if(!buffer) continue; /* buffer full */
+
+		*to_base = *to = *len = 0;
+
+		ltt_write_event_header(trace, channel, buffer,
+			ltt_facility_core_1A8DE486, event_core_facility_load,
+			reserve_size, before_hdr_pad, tsc);
+		*to_base += before_hdr_pad + after_hdr_pad + header_size;
+
+		*from = (const char*)lttng_param_name;
+		lttng_write_string_core_facility_load_name(buffer, to_base, to, from, len, lttng_param_name);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		*from = (const char*)&lttng_param_checksum;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		*from = (const char*)&lttng_param_id;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		*from = (const char*)&lttng_param_int_size;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		*from = (const char*)&lttng_param_long_size;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		*from = (const char*)&lttng_param_pointer_size;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		*from = (const char*)&lttng_param_size_t_size;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		*from = (const char*)&lttng_param_has_alignment;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		ltt_commit_slot(channel, &transport_data, buffer, slot_size);
+
+	}
+
+	ltt_nesting[smp_processor_id()]--;
+	preempt_enable_no_resched();
+}
+#endif //(!defined(CONFIG_LTT) || !defined(CONFIG_LTT_FACILITY_CORE))
+
+
+/* Event facility_unload structures */
+
+/* Event facility_unload logging function */
+static inline void trace_core_facility_unload(
+		unsigned int lttng_param_id)
+#if (!defined(CONFIG_LTT) || !defined(CONFIG_LTT_FACILITY_CORE))
+{
+}
+#else
+{
+	unsigned int index;
+	struct ltt_channel_struct *channel;
+	struct ltt_trace_struct *trace;
+	void *transport_data;
+	char *buffer = NULL;
+	size_t real_to_base = 0; /* The buffer is allocated on arch_size alignment */
+	size_t *to_base = &real_to_base;
+	size_t real_to = 0;
+	size_t *to = &real_to;
+	size_t real_len = 0;
+	size_t *len = &real_len;
+	size_t reserve_size;
+	size_t slot_size;
+	size_t align;
+	const char *real_from;
+	const char **from = &real_from;
+	u64 tsc;
+	size_t before_hdr_pad, after_hdr_pad, header_size;
+
+	if(ltt_traces.num_active_traces == 0) return;
+
+	/* For each field, calculate the field size. */
+	/* size = *to_base + *to + *len */
+	/* Assume that the padding for alignment starts at a
+	 * sizeof(void *) address. */
+
+	*from = (const char*)&lttng_param_id;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	reserve_size = *to_base + *to + *len;
+	preempt_disable();
+	ltt_nesting[smp_processor_id()]++;
+	index = ltt_get_index_from_facility(ltt_facility_core_1A8DE486,
+						event_core_facility_unload);
+
+	list_for_each_entry_rcu(trace, &ltt_traces.head, list) {
+		if(!trace->active) continue;
+
+		channel = ltt_get_channel_from_index(trace, index);
+
+		slot_size = 0;
+		buffer = ltt_reserve_slot(trace, channel, &transport_data,
+			reserve_size, &slot_size, &tsc,
+			&before_hdr_pad, &after_hdr_pad, &header_size);
+		if(!buffer) continue; /* buffer full */
+
+		*to_base = *to = *len = 0;
+
+		ltt_write_event_header(trace, channel, buffer,
+			ltt_facility_core_1A8DE486, event_core_facility_unload,
+			reserve_size, before_hdr_pad, tsc);
+		*to_base += before_hdr_pad + after_hdr_pad + header_size;
+
+		*from = (const char*)&lttng_param_id;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		ltt_commit_slot(channel, &transport_data, buffer, slot_size);
+
+	}
+
+	ltt_nesting[smp_processor_id()]--;
+	preempt_enable_no_resched();
+}
+#endif //(!defined(CONFIG_LTT) || !defined(CONFIG_LTT_FACILITY_CORE))
+
+
+/* Event time_heartbeat structures */
+
+/* Event time_heartbeat logging function */
+static inline void trace_core_time_heartbeat(
+unsigned int tracefile_index)
+#if (!defined(CONFIG_LTT) || !defined(CONFIG_LTT_FACILITY_CORE))
+{
+}
+#else
+{
+	unsigned int index;
+	struct ltt_channel_struct *channel;
+	struct ltt_trace_struct *trace;
+	void *transport_data;
+	char *buffer = NULL;
+	size_t real_to_base = 0; /* The buffer is allocated on arch_size alignment */
+	size_t *to_base = &real_to_base;
+	size_t real_to = 0;
+	size_t *to = &real_to;
+	size_t real_len = 0;
+	size_t *len = &real_len;
+	size_t reserve_size;
+	size_t slot_size;
+	u64 tsc;
+	size_t before_hdr_pad, after_hdr_pad, header_size;
+
+	if(ltt_traces.num_active_traces == 0) return;
+
+	/* For each field, calculate the field size. */
+	/* size = *to_base + *to + *len */
+	/* Assume that the padding for alignment starts at a
+	 * sizeof(void *) address. */
+
+	reserve_size = *to_base + *to + *len;
+	preempt_disable();
+	ltt_nesting[smp_processor_id()]++;
+	index = tracefile_index;
+
+	list_for_each_entry_rcu(trace, &ltt_traces.head, list) {
+		if(!trace->active) continue;
+
+		channel = ltt_get_channel_from_index(trace, index);
+
+		slot_size = 0;
+		buffer = ltt_reserve_slot(trace, channel, &transport_data,
+			reserve_size, &slot_size, &tsc,
+			&before_hdr_pad, &after_hdr_pad, &header_size);
+		if(!buffer) continue; /* buffer full */
+
+		*to_base = *to = *len = 0;
+
+		ltt_write_event_header(trace, channel, buffer,
+			ltt_facility_core_1A8DE486, event_core_time_heartbeat,
+			reserve_size, before_hdr_pad, tsc);
+		*to_base += before_hdr_pad + after_hdr_pad + header_size;
+
+		ltt_commit_slot(channel, &transport_data, buffer, slot_size);
+
+	}
+
+	ltt_nesting[smp_processor_id()]--;
+	preempt_enable_no_resched();
+}
+#endif //(!defined(CONFIG_LTT) || !defined(CONFIG_LTT_FACILITY_CORE))
+
+
+/* Event state_dump_facility_load structures */
+static inline void lttng_write_string_core_state_dump_facility_load_name(
+		char *buffer,
+		size_t *to_base,
+		size_t *to,
+		const char **from,
+		size_t *len,
+		const char * obj)
+{
+	size_t size;
+	size_t align;
+
+	/* Flush pending memcpy */
+	if(*len != 0) {
+		if(buffer != NULL)
+			memcpy(buffer+*to_base+*to, *from, *len);
+	}
+	*to += *len;
+	*len = 0;
+
+	align = sizeof(char);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	/* Contains variable sized fields : must explode the structure */
+
+	size = strlen(obj) + 1; /* Include final NULL char. */
+	if(buffer != NULL)
+		memcpy(buffer+*to_base+*to, obj, size);
+	*to += size;
+
+	/* Realign the *to_base on arch size, set *to to 0 */
+	*to += ltt_align(*to, sizeof(void *));
+	*to_base = *to_base+*to;
+	*to = 0;
+
+	/* Put source *from just after the C string */
+	*from += size;
+}
+
+
+/* Event state_dump_facility_load logging function */
+static inline void trace_core_state_dump_facility_load(
+		struct ltt_trace_struct *dest_trace,
+		const char * lttng_param_name,
+		unsigned int lttng_param_checksum,
+		unsigned int lttng_param_id,
+		unsigned int lttng_param_int_size,
+		unsigned int lttng_param_long_size,
+		unsigned int lttng_param_pointer_size,
+		unsigned int lttng_param_size_t_size,
+		unsigned int lttng_param_has_alignment)
+#if (!defined(CONFIG_LTT) || !defined(CONFIG_LTT_FACILITY_CORE))
+{
+}
+#else
+{
+	unsigned int index;
+	struct ltt_channel_struct *channel;
+	struct ltt_trace_struct *trace;
+	void *transport_data;
+	char *buffer = NULL;
+	size_t real_to_base = 0; /* The buffer is allocated on arch_size alignment */
+	size_t *to_base = &real_to_base;
+	size_t real_to = 0;
+	size_t *to = &real_to;
+	size_t real_len = 0;
+	size_t *len = &real_len;
+	size_t reserve_size;
+	size_t slot_size;
+	size_t align;
+	const char *real_from;
+	const char **from = &real_from;
+	u64 tsc;
+	size_t before_hdr_pad, after_hdr_pad, header_size;
+
+	if(ltt_traces.num_active_traces == 0) return;
+
+	/* For each field, calculate the field size. */
+	/* size = *to_base + *to + *len */
+	/* Assume that the padding for alignment starts at a
+	 * sizeof(void *) address. */
+
+	*from = (const char*)lttng_param_name;
+	lttng_write_string_core_state_dump_facility_load_name(buffer, to_base, to, from, len, lttng_param_name);
+
+	*from = (const char*)&lttng_param_checksum;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	*from = (const char*)&lttng_param_id;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	*from = (const char*)&lttng_param_int_size;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	*from = (const char*)&lttng_param_long_size;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	*from = (const char*)&lttng_param_pointer_size;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	*from = (const char*)&lttng_param_size_t_size;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	*from = (const char*)&lttng_param_has_alignment;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	reserve_size = *to_base + *to + *len;
+	preempt_disable();
+	ltt_nesting[smp_processor_id()]++;
+	index = ltt_get_index_from_facility(ltt_facility_core_1A8DE486,
+						event_core_state_dump_facility_load);
+
+	list_for_each_entry_rcu(trace, &ltt_traces.head, list) {
+		if(!trace->active) continue;
+
+		if(dest_trace != trace) continue;
+
+		channel = ltt_get_channel_from_index(trace, index);
+
+		slot_size = 0;
+		buffer = ltt_reserve_slot(trace, channel, &transport_data,
+			reserve_size, &slot_size, &tsc,
+			&before_hdr_pad, &after_hdr_pad, &header_size);
+		if(!buffer) continue; /* buffer full */
+
+		*to_base = *to = *len = 0;
+
+		ltt_write_event_header(trace, channel, buffer,
+			ltt_facility_core_1A8DE486, event_core_state_dump_facility_load,
+			reserve_size, before_hdr_pad, tsc);
+		*to_base += before_hdr_pad + after_hdr_pad + header_size;
+
+		*from = (const char*)lttng_param_name;
+		lttng_write_string_core_state_dump_facility_load_name(buffer, to_base, to, from, len, lttng_param_name);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		*from = (const char*)&lttng_param_checksum;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		*from = (const char*)&lttng_param_id;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		*from = (const char*)&lttng_param_int_size;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		*from = (const char*)&lttng_param_long_size;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		*from = (const char*)&lttng_param_pointer_size;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		*from = (const char*)&lttng_param_size_t_size;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		*from = (const char*)&lttng_param_has_alignment;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		ltt_commit_slot(channel, &transport_data, buffer, slot_size);
+
+	}
+
+	ltt_nesting[smp_processor_id()]--;
+	preempt_enable_no_resched();
+}
+#endif //(!defined(CONFIG_LTT) || !defined(CONFIG_LTT_FACILITY_CORE))
+
+
+#endif //_LTT_FACILITY_CORE_H_
--- /dev/null
+++ b/include/linux/ltt/ltt-facility-id-core.h
@@ -0,0 +1,24 @@
+#ifndef _LTT_FACILITY_ID_CORE_H_
+#define _LTT_FACILITY_ID_CORE_H_
+
+#ifdef CONFIG_LTT
+#include <linux/ltt-facilities.h>
+
+/****  facility handle  ****/
+
+extern ltt_facility_t ltt_facility_core_1A8DE486;
+extern ltt_facility_t ltt_facility_core;
+
+
+/****  event index  ****/
+
+enum core_event {
+	event_core_facility_load,
+	event_core_facility_unload,
+	event_core_time_heartbeat,
+	event_core_state_dump_facility_load,
+	facility_core_num_events
+};
+
+#endif //CONFIG_LTT
+#endif //_LTT_FACILITY_ID_CORE_H_

--=_Krystal-17099-1158393289-0001-2--
